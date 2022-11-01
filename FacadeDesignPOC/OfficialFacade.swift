//
//  OfficialFacade.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/30/22.
//

import Foundation

let apiKey = "22b91345146d319fa81856e84af973313d5708b4a0049f89d0917aa87bafadbc"

protocol GameOfficialFacadeProtocol {
    func judgeTheGame()
}

class GameOfficialFacade: GameOfficialFacadeProtocol {
    let gameModel: GameModel
    
    init(gameModel: GameModel) {
        self.gameModel = gameModel
    }
    
    func judgeTheGame() {
        Task{
            do {
                try await judgeSubmittedWords()
                checkForWinner()
                pickNewLanguage()
                downloadNewLanguage()
                reorganizeGameBoard()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func judgeSubmittedWords() async throws {
        let url = URL(string: "https://serpapi.com/search.json?q=Coffeee&hl=en&gl=us&api_key=\(apiKey)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, response) = try await URLSession(configuration: .default).data(for: request)
        let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
        let subJson = json["search_information"] as! [String:Any]
        let spelledWord = subJson["spelling_fix"] as! String
        print(spelledWord)
    }
    
    private func checkForWinner() {
        print("Placeholder")
    }
    
    private func pickNewLanguage() {
        print("Placeholder")
    }
    
    private func downloadNewLanguage() {
        print("Placeholder")
    }
    
    private func reorganizeGameBoard() {
        print("Placeholder")
    }
}
