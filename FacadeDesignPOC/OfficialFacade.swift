//
//  OfficialFacade.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/30/22.
//

import Foundation

protocol GameOfficialFacadeProtocol {
    func judgeTheGame()
}

class GameOfficialFacade: GameOfficialFacadeProtocol {
    let gameModel: GameModel
    
    init(gameModel: GameModel) {
        self.gameModel = gameModel
    }
    
    func judgeTheGame() {
        judgeSubmittedWords()
        addUpPointTotals()
        checkForWinner()
        pickNewLanguage()
        downloadNewLanguage()
        reorganizeGameBoard()
    }
    
    private func judgeSubmittedWords() {
        print("Placeholder")
    }
    
    private func addUpPointTotals() {
        print("Placeholder")
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
