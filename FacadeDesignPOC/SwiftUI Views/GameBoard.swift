//
//  GameBoard.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/28/22.
//

import SwiftUI

struct GameBoard: View {
    @EnvironmentObject var gameSettings: GameSettings
    @State var gameModel = GameModel()
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
                for letter in self.gameSettings.selectedTurnLetters {
                    newWord.append(letter)
                }
                if self.gameSettings.isPlayerOne {
                    gameModel.submitPlayerOneWord(newWord: newWord.lowercased())
                } else {
                    gameModel.submitPlayerTwoWord(newWord: newWord.lowercased())
                }
                
                gameSettings.selectedTurnLetters = []
                if tapCount == 2 {
                    turnCount += 1
                    turnDisplay -= 1
                    tapCount = 0
                }
                if turnCount > 2 {
                    turnDisplay = 0
                    gameSettings.loading = true
                    Task {
                        try await gameModel.submitWordsToOfficial()
                        displayMessage = gameModel.resultMessage
                        gameSettings.loading = false
                        displayAlert.toggle()
                        gameModel.clearWordBoard()
                        turnDisplay = 3
                        tapCount = 0
                        self.gameSettings.gameOver.toggle()
                    }
                } else {
                    self.gameSettings.isPlayerOne.toggle()
                    currentText = self.gameSettings.isPlayerOne ? "One" : "Two"
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
                gameSettings.selectedTurnLetters = []
                gameSettings.gameOver.toggle()
                gameModel.clearWordBoard()
                turnDisplay = 3
                gameSettings.isPlayerOne = true
                turnCount = 0
                currentText = self.gameSettings.isPlayerOne ? "One" : "Two"
                tapCount = 0
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
