//
//  FacadeDesignPOCApp.swift
//  FacadeDesignPOC
//
//  Created by Jon Iger
//  Holds our main starting point, in addition to global variables and constants used throughout the app
//

import SwiftUI

// global supporting variables
let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
let fileURL = URL(fileURLWithPath: "log", relativeTo: directoryURL).appendingPathExtension("txt")
let startingLetters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

@main
struct WordCreate: App {
    var gameSettings = GameSettings()
    var body: some Scene {
        WindowGroup {
            // attach a fresh copy of our EnvironmentObject to our instance of ContentView() for use in the app later on
            ContentView().environmentObject(gameSettings)
        }
    }
}
