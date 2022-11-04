//
//  FacadeDesignPOCApp.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon
//  Holds our main starting point, in addition to global variables and constants used throughout the app
//

import SwiftUI

// global supporting variables
let apiKey = "099784a80b57d7a110eb74594d4d625f7c6b68704fc0214a4555d4a63bf4efa0"     //serpAPI api key used with GitHub
let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
let fileURL = URL(fileURLWithPath: "log", relativeTo: directoryURL).appendingPathExtension("txt")
let startingLetters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

@main
struct FacadeDesignPOCApp: App {
    var gameSettings = GameSettings()
    var body: some Scene {
        WindowGroup {
            // attach a fresh copy of our EnvironmentObject to our instance of ContentView() for use in the app later on
            ContentView().environmentObject(gameSettings)
        }
    }
}
