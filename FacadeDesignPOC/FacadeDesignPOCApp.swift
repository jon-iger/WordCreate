//
//  FacadeDesignPOCApp.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon
//  Holds our main starting point
//

import SwiftUI

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
