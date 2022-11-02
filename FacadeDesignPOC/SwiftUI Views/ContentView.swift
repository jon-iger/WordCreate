//
//  ContentView.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/26/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var currentLetters: GameSettings
    var body: some View {
        VStack(alignment: .center) {
            GameBoard()
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameSettings())
    }
}
