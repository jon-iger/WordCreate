//
//  GameModel.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon
//  Holds our app's data model for a typical game
//

import Foundation
import UIKit

/**
 GameModelProtocol: protocol for enabling GameModel functionality
 Methods
 - clearWordBoard(): clear all of the selected words that both players have ended their turns on
 - submitPlayerOneWord(newWord: String): submit (a.k.a. add a new word to the player) a new word to be added to the GameModel's playerOneWords array
 - submitPlayerTwoWord(newWord: String): submit (a.k.a. add a new word to the player) a new word to be added to the GameModel's playerTwoWords array
 - submitWordsToOfficial() async throws: method that handles connecting to the facade to end/restart the game
 */
protocol GameModelProtocol {
    func clearWordBoard()
    func submitPlayerOneWord(newWord: String)
    func submitPlayerTwoWord(newWord: String)
    func submitWordsToOfficial() async throws
}

/**
 GameModel: our basic data model for storing most of the common properties for a game
 Methods
 - playerOneWords/[String]: array for storing the list of words submitted by the first player
 - playerTwoWords/[String]: array for storing the list of words submitted by the two player
 - boardLetters/[String]: array for storing the list of letters being used in the game (what letters are displayed on screen in blocks)
 - resultMessage/String: message string to be displayed annoucing the results of the game to the user (win/lose/tie)
 */
class GameModel: GameModelProtocol {
    var playerOneWords: [String]
    var playerTwoWords: [String]
    var boardLetters: [String]
    var resultMessage: String
    
    /**
     init()
     No parameters needed for this
     New game is to start with players having not submitted words, the default set of letters, and a blank result string
     */
    init() {
        self.playerOneWords = []
        self.playerTwoWords = []
        self.boardLetters = startingLetters
        self.resultMessage = String()
    }
    
    /**
     clearWordBoard(): clears all words that have been submitted by the player by clearing both player word arrays
     */
    func clearWordBoard() {
        playerOneWords = []
        playerTwoWords = []
    }
    
    /**
     submitPlayerOneWord(newWord: String): using the newWord parameter, a new word is added to the first player's word list
     */
    func submitPlayerOneWord(newWord: String) {
        playerOneWords.append(newWord)
    }
    
    /**
     submitPlayerTwoWord(newWord: String): using the newWord parameter, a new word is added to the second player's word list
     */
    func submitPlayerTwoWord(newWord: String) {
        playerTwoWords.append(newWord)
    }
    
    /**
     submitWordsToOfficial(): async method that activates our "facade" object and handles API calls and file writing functionality
     */
    func submitWordsToOfficial() async throws {
        let facade = GameOfficialFacade(gameModel: self)
        // call our async facade method, and do not advance until the method is complete
        try await facade.judgeTheGame()
        print("Judge complete")
    }
}
