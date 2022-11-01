//
//  GameBoard.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/28/22.
//

import SwiftUI

struct GameBoard: View {
    @EnvironmentObject var currentLetters: GameSettings
    var gameModel = GameModel()
    @State var letterArray: [String] = []
    @State var playerOne = true
    @State var currentText = "One"
    @State var turnCount = 4
    var body: some View {
        VStack(alignment: .center) {
            Text("Current Player \(currentText)")
                .font(.largeTitle)
            Text("\(turnCount) Turns Left")
                .font(.largeTitle)
                .fontWeight(.bold)
            ForEach(0..<8) { index in
                GameRow(modal: gameModel)
            }
            
            //Done Button
            Button(action: {
                var newWord = String()
                for letter in self.currentLetters.selectedTurnLetters {
                    newWord.append(letter)
                }
                if playerOne {
                    gameModel.submitPlayerOneWord(newWord: newWord)
                } else {
                    gameModel.submitPlayerTwoWord(newWord: newWord)
                }
                
                if turnCount == 0 {
                    gameModel.submitWordsToOfficial()
                } else {
                    turnCount = !playerOne ? turnCount - 1 : turnCount
                    playerOne.toggle()
                    currentText = playerOne ? "One" : "Two"
                    self.currentLetters.isPlayerOne.toggle()
                }
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
                currentLetters.selectedTurnLetters = []
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
            .environmentObject(GameSettings())
    }
}
