//
//  OfficialFacade.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/30/22.
//

import Foundation

let apiKey = "22b91345146d319fa81856e84af973313d5708b4a0049f89d0917aa87bafadbc"
let imageNames = ["alphabet1", "alphabet2"]

protocol GameOfficialFacadeProtocol {
    func judgeTheGame() async throws
}

class GameOfficialFacade: GameOfficialFacadeProtocol {
    let gameModel: GameModel
    var playerOnePoints: Int
    var playerTwoPoints: Int
    
    init(gameModel: GameModel) {
        self.gameModel = gameModel
        self.playerOnePoints = 0
        self.playerTwoPoints = 0
    }
    
    func judgeTheGame() async throws {
        try await judgeSubmittedWords(playerWords: self.gameModel.playerOneWords, playerNum: 1)
        try await judgeSubmittedWords(playerWords: self.gameModel.playerTwoWords, playerNum: 2)
        checkForWinner()
        pickNewLanguage()
        downloadNewBackground()
        reorganizeGameBoard()
    }
    
    private func judgeSubmittedWords(playerWords: [String], playerNum: Int) async throws {
        for word in playerWords {
            let url = URL(string: "https://serpapi.com/search.json?q=\(word)&hl=en&gl=us&api_key=\(apiKey)")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let (data, response) = try await URLSession(configuration: .default).data(for: request)
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            let subJson = json["search_information"] as! [String:Any]
            // can return nil if given nonsense word??
            if let spelledWord = subJson["spelling_fix"] as? String {
                print(spelledWord)
                if spelledWord == word && playerNum == 1 {
                    playerOnePoints += word.count
                } else if spelledWord == word && playerNum == 2 {
                    playerTwoPoints += word.count
                }
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
    
    private func pickNewLanguage() {
        self.gameModel.currentLanguage = supportedLanguages.shuffled()[0]
    }
    
    private func downloadNewBackground() {
        
    }
    
    private func reorganizeGameBoard() {
        print("Placeholder")
    }
}
