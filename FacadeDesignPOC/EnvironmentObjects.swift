//
//  EnvironmentObjects.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/30/22.
//

import Foundation

class GameSettings: ObservableObject {
    @Published var selectedTurnLetters: [String] = []
    @Published var isPlayerOne = true
}
