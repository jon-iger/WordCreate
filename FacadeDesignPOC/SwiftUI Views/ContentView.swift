//
//  ContentView.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/26/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameSettings: GameSettings
    @State var gameBoard: GameBoard = GameBoard()
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                gameBoard
            }
            .task {
                do {
                    try FileManager.default.removeItem(at: fileURL)
                } catch {
                    print(error.localizedDescription)
                }
                let myString = ""
                guard let data = myString.data(using: .utf8) else {
                    print("Unable to convert string to data")
                    return
                }
                do {
                    try data.write(to: fileURL)
                    print("File saved: \(fileURL.absoluteURL)")
                } catch {
                    print(error.localizedDescription)
                }
            }
            if gameSettings.loading {
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
