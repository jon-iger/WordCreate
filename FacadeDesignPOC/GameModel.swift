//
//  GameModel.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/30/22.
//

import Foundation

// Global supporting variables
let defaultStartingLetters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y"]
let supportedLanguages = ["English", "Spanish", "French", "German"]
let turnCount = 4

protocol GameModelProtocol {
    func clearWordBoard()
    func submitPlayerOneWord(newWord: String)
    func submitPlayerTwoWord(newWord: String)
    func submitWordsToOfficial()
    func gameRestart()
}

class GameModel: GameModelProtocol {
    var playerOneWords: [String]
    var playerTwoWords: [String]
    var currentLanguage: String
    var boardLetters: [String]
    var resultMessage: String
    
    init() {
        self.playerOneWords = []
        self.playerTwoWords = []
        self.currentLanguage = "English"
        self.boardLetters = defaultStartingLetters
        self.resultMessage = String()
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
    
    func submitWordsToOfficial() {
        let facade = GameOfficialFacade(gameModel: self)
        facade.judgeTheGame()
    }
    
    func gameRestart() {
        print("Placeholder")
    }
}
