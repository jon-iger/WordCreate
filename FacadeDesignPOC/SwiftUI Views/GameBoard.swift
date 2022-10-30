//
//  GameBoard.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/28/22.
//

import SwiftUI

struct GameBoard: View {
    var gameModel = GameModel()
    @State var letterArray: [String] = []
    @State var playerOne = true
    @State var currentText = "One"
    var body: some View {
        VStack(alignment: .center) {
            Text("Current Player \(currentText)")
                .font(.largeTitle)
            Text("4 Turns Left")
                .font(.largeTitle)
                .fontWeight(.bold)
            ForEach(1..<6) { index in
                GameRow(letterArray: letterArray)
                    .task {
                        letterArray = gameModel.addNewWords()
                    }
                    .refreshable {
                        // need "await" keyword here??
                        letterArray = gameModel.addNewWords()
                    }
            }
            
            //Done Button
            Button(action: {
                playerOne.toggle()
                currentText = playerOne ? "One" : "Two"
            }) {
                Text("Turn Done")
                    .font(.title)
                    .frame(width: 160, height: 20)
                    .padding(15)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(15)
            }
            Button(action: {
                gameModel.clearWordBoard()
            }) {
                Text("Clear Selection")
                    .font(.title)
                    .frame(width: 190, height: 20)
                    .padding(15)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(15)
            }
        }
    }
}

struct GameBoard_Previews: PreviewProvider {
    static var previews: some View {
        GameBoard(letterArray: ["A", "B", "C", "D", "E"])
    }
}
