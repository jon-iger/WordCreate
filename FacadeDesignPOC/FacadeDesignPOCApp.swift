//
//  FacadeDesignPOCApp.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon
//  Holds our main starting point, in addition to global variables and constants used throughout the app
//

import SwiftUI

// global supporting variables
let apiKey = "22b91345146d319fa81856e84af973313d5708b4a0049f89d0917aa87bafadbc"
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
