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
    func updatePointCount(newPlayerOnePoints: Int, newPlayerTwoPoints: Int)
    func submitPlayerOneWord(newWord: String)
    func submitPlayerTwoWord(newWord: String)
    func submitWordsToOfficial()
    func gameRestart()
}

class GameModel: GameModelProtocol {
    var playerOneWords: [String]
    var playerTwoWords: [String]
    var playerOnePoints: Int
    var playerTwoPoints: Int
    var playerOneTurnCount: Int
    var playerTwoTurnCount: Int
    var currentLanguage: String
    var boardLetters: [String]
    
    init() {
        self.playerOneWords = []
        self.playerTwoWords = []
        self.playerOnePoints = 0
        self.playerTwoPoints = 0
        self.playerOneTurnCount = 4
        self.playerTwoTurnCount = 4
        self.currentLanguage = "English"
        self.boardLetters = defaultStartingLetters
    }
    
    func clearWordBoard() {
        playerOneWords = []
        playerTwoWords = []
    }
    
    func updatePointCount(newPlayerOnePoints: Int, newPlayerTwoPoints: Int) {
        self.playerOnePoints += newPlayerOnePoints
        self.playerTwoPoints += newPlayerTwoPoints
    }
    
    func addNewWords() -> [String] {
        return ["A", "B", "C", "D", "E"]
    }
    
    func submitPlayerOneWord(newWord: String) {
        playerOneWords.append(newWord)
    }
    
    func submitPlayerTwoWord(newWord: String) {
        playerTwoWords.append(newWord)
    }
    
    func submitWordsToOfficial() {
        print("Placeholder")
    }
    
    func gameRestart() {
        print("Placeholder")
    }
}
