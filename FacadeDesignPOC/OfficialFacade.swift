//
//  OfficialFacade.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon
//  Facade file for managing anything/everything that takes place after a game is completed by the user
//

import Foundation

/**
 GameOfficialFacadeProtocol: protocol for our GameOfficialFacade object
 */
protocol GameOfficialFacadeProtocol {
    func judgeTheGame() async throws
}

/**
 GameOfficialFacade: class "facade" that handles the rules of the game and determines a winner
 - gameModel: GameModel: gameModel taken in as a parameter for the facade to manipulate during it's operations
 - playerOnePoints: Int: the total amount of points the first player has scored
 - playerTwoPoints: Int: the total amount of points the first player has scored
 - auditedPlayerOneWords: [String]: the final list of allowed "non-duplicate words" that are assembled to be checked through our search API for the first player
 - auditedPlayerTwoWords: [String]: the final list of allowed "non-duplicate words" that are assembled to be checked through our search API for the second player
 - correctWords: [String]: the array of words checked by the API that are determined to be "correct", and cannot be used again in future games in that session
 */
class GameOfficialFacade: GameOfficialFacadeProtocol {
    let gameModel: GameModel
    var playerOnePoints: Int
    var playerTwoPoints: Int
    var auditedPlayerOneWords: [String]
    var auditedPlayerTwoWords: [String]
    var correctWords: [String]
    
    /**
     init
     only a GameModel object is needed here, as this will be used to manipulate data
     */
    init(gameModel: GameModel) {
        self.gameModel = gameModel
        self.playerOnePoints = 0
        self.playerTwoPoints = 0
        self.auditedPlayerOneWords = []
        self.auditedPlayerTwoWords = []
        self.correctWords = []
    }
    
    /**
     judgeTheGame() async throws: main "facade" method that is called to handle anything and everything related to judging the game and preparing for the next one
     */
    func judgeTheGame() async throws {
        auditSubmittedWords(playerWords: self.gameModel.playerOneWords, playerNum: 1)
        auditSubmittedWords(playerWords: self.gameModel.playerTwoWords, playerNum: 2)
        try await judgeSubmittedWords(playerWords: auditedPlayerOneWords, playerNum: 1)
        try await judgeSubmittedWords(playerWords: auditedPlayerTwoWords, playerNum: 2)
        checkForWinner()
        addRestrictedWords()
    }
    
    /**
     judgeSubmittedWords(playerWords: [String], playerNum: Int) async throws
     async method responsible for taking a player's words and checking them through our API to see if they're spelled correctly or not
     */
    private func judgeSubmittedWords(playerWords: [String], playerNum: Int) async throws {
        for word in playerWords {
            // create the URL and our request
            let url = URL(string: "https://serpapi.com/search.json?q=\(word)&hl=en&gl=us&api_key=\(apiKey)")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            //take in what data is given and process accordingly
            let (data, _) = try await URLSession(configuration: .default).data(for: request)
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            let subJson = json["search_information"] as! [String:Any]
            
            // organic results state means the API was able to search for the word without modifiying the spelling
            // this means that the word was spelled correctly, so proceed to scoring
            // if this if/let fails and organic results state was not found, it means incorrect spelling
            if let status = subJson["organic_results_state"] as? String {
                //for each letters in the word, a point is added to the player total (if it was spelled correctly in the above check
                if status == "Results for exact spelling" && playerNum == 1 {
                    playerOnePoints += word.count
                } else if status == "Results for exact spelling" && playerNum == 2 {
                    playerTwoPoints += word.count
                }
                // since this is a new word to the game session, add it to the correctWords array to be processed later
                correctWords.append(word)
            }
        }
    }
    
    /**
     checkForWinner(): method to produce the string message to be dispalyed in the alert when the game is over
     */
    private func checkForWinner() {
        if playerOnePoints > playerTwoPoints {
            self.gameModel.resultMessage = "Player One Won!"
        } else if playerTwoPoints > playerOnePoints {
            self.gameModel.resultMessage = "Player Two Won!"
        } else {
            self.gameModel.resultMessage = "On no! It's a tie"
        }
        print(self.gameModel.resultMessage)
    }
    
    /**
     auditSubmittedWords(playerWords: [String], playerNum: Int): for the given player's words, check our log file to see if the word has already been played
     if played already, word will not be submitted to the API (to save on redundant API calls), otherwise it will submitted
     */
    private func auditSubmittedWords(playerWords: [String], playerNum: Int) {
        do {
            // Get the saved data from our log file
            let savedData = try Data(contentsOf: fileURL)
            if let stringData = String(data: savedData, encoding: .utf8) {
                let wordsSaved = stringData.components(separatedBy: ",")
                // for each word in the list of submitted player words, check if it already exists in the file
                // if not, it's ready for API check, otherwise, it won't be used by the API (to reduce redundant API calls)
                for playerWord in playerWords {
                    if !wordsSaved.contains(playerWord) && playerNum == 1 {
                        auditedPlayerOneWords.append(playerWord)
                    } else if !wordsSaved.contains(playerWord) && playerNum == 2 {
                        auditedPlayerTwoWords.append(playerWord)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /**
     addRestrictedWords(): using what words are considered "new" to the current game session and "correct" from the API, prevent these words from being used again by adding them to the restricted file list
     */
    private func addRestrictedWords() {
        // for each word in the "new and correct" words list, add this word to the restricted word list file
        // to prevent the word from being scored again in the same game session
        for restrictedWord in correctWords {
            // amend string written to the file with "," for use when the file is being read later on
            let fileWord = restrictedWord + ","
            guard let data = fileWord.data(using: .utf8) else {
                print("Cannot convert to Data. Returning from here")
                return
            }
            // Save the new word to the file if the type conversion is successful
            do {
                try data.write(to: fileURL)
                print("File update completed successfully")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
