//
//  OfficialFacade.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/30/22.
//

import Foundation

let apiKey = "22b91345146d319fa81856e84af973313d5708b4a0049f89d0917aa87bafadbc"
let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
let fileURL = URL(fileURLWithPath: "log", relativeTo: directoryURL).appendingPathExtension("txt")

protocol GameOfficialFacadeProtocol {
    func judgeTheGame() async throws
}

class GameOfficialFacade: GameOfficialFacadeProtocol {
    let gameModel: GameModel
    var playerOnePoints: Int
    var playerTwoPoints: Int
    var auditedPlayerOneWords: [String]
    var auditedPlayerTwoWords: [String]
    var correctWords: [String]
    
    init(gameModel: GameModel) {
        self.gameModel = gameModel
        self.playerOnePoints = 0
        self.playerTwoPoints = 0
        self.auditedPlayerOneWords = []
        self.auditedPlayerTwoWords = []
        self.correctWords = []
    }
    
    func judgeTheGame() async throws {
        auditSubmittedWords(playerWords: self.gameModel.playerOneWords, playerNum: 1)
        auditSubmittedWords(playerWords: self.gameModel.playerTwoWords, playerNum: 2)
        try await judgeSubmittedWords(playerWords: auditedPlayerOneWords, playerNum: 1)
        try await judgeSubmittedWords(playerWords: auditedPlayerTwoWords, playerNum: 2)
        checkForWinner()
        addRestrictedWords()
        reorganizeGameBoard()
    }
    
    private func judgeSubmittedWords(playerWords: [String], playerNum: Int) async throws {
        for word in playerWords {
            let url = URL(string: "https://serpapi.com/search.json?q=\(word)&hl=en&gl=us&api_key=\(apiKey)")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let (data, _) = try await URLSession(configuration: .default).data(for: request)
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            let subJson = json["search_information"] as! [String:Any]
            if let status = subJson["organic_results_state"] as? String {
                if status == "Results for exact spelling" && playerNum == 1 {
                    playerOnePoints += word.count
                } else if status == "Results for exact spelling" && playerNum == 2 {
                    playerTwoPoints += word.count
                }
                correctWords.append(word)
            }
        }
    }
    
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
    
    private func auditSubmittedWords(playerWords: [String], playerNum: Int) {
        do {
            // Get the saved data
            let savedData = try Data(contentsOf: fileURL)
            if let savedString = String(data: savedData, encoding: .utf8) {
                print(savedString)
                let wordsSaved = savedString.components(separatedBy: ",")
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
    
    private func addRestrictedWords() {
        for restrictedWord in correctWords {
            guard let data = restrictedWord.data(using: .utf8) else {
                print("Cannot convert to Data. Returning from here.")
                return
            }
            // Save the data
            do {
                try data.write(to: fileURL)
                print("File saved: \(fileURL.absoluteURL)")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func reorganizeGameBoard() {
        gameModel.boardLetters = gameModel.boardLetters.shuffled()
    }
}
