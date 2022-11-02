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
    @State var currentText = "One"
    @State var turnCount = 0
    @State var turnDisplay = 3
    @State var tapCount = 0
    @State var displayMessage = String()
    @State private var displayAlert = false
    var body: some View {
        VStack(alignment: .center) {
            Text("Current Player \(currentText)")
                .font(.largeTitle)
            Text("\(turnDisplay) Turns Left")
                .font(.largeTitle)
                .fontWeight(.bold)
            ForEach(0..<8) { index in
                GameRow(modal: gameModel)
            }
            
            //Done Button
            Button(action: {
                tapCount += 1
                var newWord = String()
                for letter in self.currentLetters.selectedTurnLetters {
                    newWord.append(letter)
                }
                if self.currentLetters.isPlayerOne {
                    gameModel.submitPlayerOneWord(newWord: newWord)
                } else {
                    gameModel.submitPlayerTwoWord(newWord: newWord)
                }
                
                currentLetters.selectedTurnLetters = []
                if tapCount == 2 {
                    turnCount += 1
                    turnDisplay -= 1
                    tapCount = 0
                }
                if turnCount > 2 {
                    turnDisplay = 0
                    Task {
                        try await gameModel.submitWordsToOfficial()
                        displayMessage = gameModel.resultMessage
                        displayAlert.toggle()
                    }
                } else {
                    self.currentLetters.isPlayerOne.toggle()
                    currentText = self.currentLetters.isPlayerOne ? "One" : "Two"
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
            .alert(isPresented: $displayAlert) {
                Alert(title: Text("Game Over"), message: Text(displayMessage), dismissButton: .default(Text("OK")))
            }
            
            Button(action: {
                currentLetters.selectedTurnLetters = []
                turnCount = 0
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
