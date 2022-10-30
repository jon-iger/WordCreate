//
//  OfficialFacade.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/30/22.
//

import Foundation

protocol GameOfficialFacadeProtocol {
    func judgeSubmittedWords()
    func addUpPointTotals()
    func checkForWinner()
    func pickNewLanguage()
    func downloadNewLanguage()
    func reorganizeGameBoard()
}

class GameOfficialFacade: GameOfficialFacadeProtocol {
    let gameModel: GameModel
    
    init(gameModel: GameModel) {
        self.gameModel = gameModel
    }
    
    func judgeSubmittedWords() {
        print("Placeholder")
    }
    
    func addUpPointTotals() {
        print("Placeholder")
    }
    
    func checkForWinner() {
        print("Placeholder")
    }
    
    func pickNewLanguage() {
        print("Placeholder")
    }
    
    func downloadNewLanguage() {
        print("Placeholder")
    }
    
    func reorganizeGameBoard() {
        print("Placeholder")
    }
}
