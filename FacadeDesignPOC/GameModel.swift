//
//  GameModel.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/30/22.
//

import Foundation
import UIKit

// Global supporting variables
let defaultStartingLetters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y"]

protocol GameModelProtocol {
    func clearWordBoard()
    func submitPlayerOneWord(newWord: String)
    func submitPlayerTwoWord(newWord: String)
    func submitWordsToOfficial() async throws
}

class GameModel: GameModelProtocol {
    var playerOneWords: [String]
    var playerTwoWords: [String]
    var boardLetters: [String]
    var resultMessage: String
    var backgroundImage: UIImage!
    var displayResultMessage: Bool
    
    init() {
        self.playerOneWords = []
        self.playerTwoWords = []
        self.boardLetters = defaultStartingLetters
        self.resultMessage = String()
        self.backgroundImage = nil
        self.displayResultMessage = false
    }
    
    func clearWordBoard() {
        playerOneWords = []
        playerTwoWords = []
    }
    
    func submitPlayerOneWord(newWord: String) {
        playerOneWords.append(newWord)
    }
    
    func submitPlayerTwoWord(newWord: String) {
        playerTwoWords.append(newWord)
    }
    
    func submitWordsToOfficial() async throws {
        let facade = GameOfficialFacade(gameModel: self)
        try await facade.judgeTheGame()
        print("Judge complete")
    }
}
