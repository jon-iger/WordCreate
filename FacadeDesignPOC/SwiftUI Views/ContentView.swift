//
//  ContentView.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon
//  File that holds our app's main content, and displays the game board to the user
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameSettings: GameSettings
    // every game will start with a fresh instance of a GameBoard object
    @State var gameBoard: GameBoard = GameBoard()
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                gameBoard
            }
            .task {
                // at the start of each game, delete the log file containing restricted words (if one exists)
                // user is supposed to start wtih no restricted words everytime the app is opened/closed
                do {
                    try FileManager.default.removeItem(at: fileURL)
                } catch {
                    print(error.localizedDescription)
                }
                let emptyString = ""
                guard let data = emptyString.data(using: .utf8) else {
                    print("Unable to convert string to data")
                    return
                }
                do {
                    try data.write(to: fileURL)
                    print("File created on launch")
                } catch {
                    print(error.localizedDescription)
                }
            }
            if gameSettings.loading {
                // if the loading of our facade starts, display the loading indicator to the user
                HiddenIndicator(hiddenStatus: !gameSettings.loading)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameSettings())
    }
}
