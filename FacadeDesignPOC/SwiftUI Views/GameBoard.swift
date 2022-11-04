//
//  GameBoard.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon
//  File holding our "board" for the game (multiple rows made up of blocks plus functionality buttons)
//

import SwiftUI

struct GameBoard: View {
    @EnvironmentObject var gameSettings: GameSettings
    @State var gameModel = GameModel()      // every game is start with a fresh model
    @State var currentText = "One"  // on-screen text indicating which player's turn it is
    @State var turnCount = 0    // amount of turns that have taken place
    @State var turnDisplay = 3      //amount of turns remaining to be displayed to the user
    @State var tapCount = 0     // amount of times the "Done" button has been pressed
    @State var displayMessage = String()    // SwiftUI friendly string for displaying the end result of the game in our Alert below
    @State private var displayAlert = false     // SwiftUI value for determining if the Alert should be displayed or not
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
            
            // Done Button
            Button(action: {
                // increase the value indicating how many times the button is tapped
                tapCount += 1
                // create the new word by taking the letters selected by the user
                var newWord = String()
                for letter in self.gameSettings.selectedTurnLetters {
                    newWord.append(letter)
                }
                // if player one/two, give the word to the model to be added/processed to lowercase
                if self.gameSettings.isPlayerOne {
                    gameModel.submitPlayerOneWord(newWord: newWord.lowercased())
                } else {
                    gameModel.submitPlayerTwoWord(newWord: newWord.lowercased())
                }
                
                // clear the letters selected, for the next player
                gameSettings.selectedTurnLetters = []
                
                // if the button was pressed twice in a game, adjust the turn count properties and reset the tap counter
                if tapCount == 2 {
                    turnCount += 1
                    turnDisplay -= 1
                    tapCount = 0
                }
                
                // if the alloted amount of turns has been reached, prepare to end the game
                if turnCount > 2 {
                    // start the loading indicator
                    turnDisplay = 0
                    gameSettings.loading = true
                    
                    // create our Task to handle the async task of processing how the game is to end
                    Task {
                        try await gameModel.submitWordsToOfficial()
                        displayMessage = gameModel.resultMessage
                        // loading/judging of the game is complete, hide the loading indicator view from the ZStack
                        gameSettings.loading = false
                        // display the Alert containing the result of the game
                        displayAlert.toggle()
                        // clear submitted words in the previous game
                        gameModel.clearWordBoard()
                        // reset display values
                        turnDisplay = 3
                        turnCount = 0
                        tapCount = 0
                        // indicate that a single game is now in the game over status
                        self.gameSettings.gameOver.toggle()
                        currentText = "One"
                    }
                } else {
                    // if the game is not over yet (amount of allowed turns has not been reached, allow the game to continue by adjusting on screen text/properties
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
                Alert(title: Text("Game Over"), message: Text(displayMessage), dismissButton: .default(Text("New Game")))
            }
            
            // Clear Button
            Button(action: {
                // when pressed, game should reset as if being opened for the first time
                // NOTE: restricted words file IS NOT reset here, this is by design
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
        GameBoard()
            .environmentObject(GameSettings())
    }
}
