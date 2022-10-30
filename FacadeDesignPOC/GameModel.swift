//
//  GameModel.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/30/22.
//

import Foundation

protocol GameModelProtocol {
    func clearWordBoard()
    func updatePointCount(newPlayerOnePoints: Int, newPlayerTwoPoints: Int)
    func submitWords()
}

class GameModel: GameModelProtocol {
    var playerOneWords: [String]
    var playerTwoWords: [String]
    var playerOnePoints: Int
    var playerTwoPoints: Int
    var currentLanguage: String
    var boardLetters: [String]
    
    init(boardLetters: [String]) {
        self.playerOneWords = []
        self.playerTwoWords = []
        self.playerOnePoints = 0
        self.playerTwoPoints = 0
        self.currentLanguage = "English"
        self.boardLetters = boardLetters
    }
    
    func clearWordBoard() {
        playerOneWords = []
        playerTwoWords = []
    }
    
    func updatePointCount(newPlayerOnePoints: Int, newPlayerTwoPoints: Int) {
        self.playerOnePoints += newPlayerOnePoints
        self.playerTwoPoints += newPlayerTwoPoints
    }
    
    func addNewWords() {
        
    }
    
    func submitWords() {
        print("Placeholder")
    }
}
