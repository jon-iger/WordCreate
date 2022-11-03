//
//  EnvironmentObjects.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon
//  File for holding the app's EnvironmentObjects
//

import Foundation

/**
 GameSettings: class designed to hold a variety of certain settings/characteristics of the game
 Variables
 - selectedTurnLetters/[String]: for any player's turn, this array stores what letters on screen the player has selected
 - isPlayerOne/Bool: indicator of whether or not player one or two is actively taking a turn at a given time
 - gameOver/Bool: indicator value of whether or not a game is over, or actively still being played
 - loading/Bool: indicator value of whether or not the loading process to determine the winner of the game, is actively ongoing
 */
class GameSettings: ObservableObject {
    @Published var selectedTurnLetters: [String] = []
    @Published var isPlayerOne = true
    @Published var gameOver = false
    @Published var loading = false
}
