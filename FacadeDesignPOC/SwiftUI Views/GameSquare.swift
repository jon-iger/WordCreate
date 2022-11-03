//
//  GameSquare.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon
//  File holding the SwiftUI view that represents a single individual square for our game
//

import SwiftUI

struct GameSquare: View {
    @EnvironmentObject var gameSettings: GameSettings
    let gameModel: GameModel    // model object taken in by every square
    @State var blockLetter = String()   // what letter is displayed in the block to the user
    @State var selected = false     //value indicating if the block is tapped on by the user or not
    @State var squareBackground = Color.yellow      //the background color of the square itself
    @State var textBackground = Color.black     //the background color of the text in the square
    var body: some View {
        Button(action: squareTap) {
            ZStack(alignment: .center){
                Rectangle()
                    .foregroundColor(squareBackground)
                    .frame(width: 50, height: 50)
                    .border(.black)
                Text(blockLetter)
                    .font(.title)
                    .foregroundColor(textBackground)
                    .task {
                        // when view is called, get a letter from the getLetter method to display
                        blockLetter = getLetter()
                    }
            }
        }
        .task(id: gameSettings.gameOver) {
            // when the game's gameOver method changes, call this task to reset the square to "starting" property values
            squareBackground = .yellow
            textBackground = .black
            blockLetter = getLetter()
            selected = false
        }
    }
    
    /**
     squareTap(): when the user taps on a square, process the letter and change the square to indicate it was selected
     */
    func squareTap() {
        selected.toggle()
        let selectionColor: Color = gameSettings.isPlayerOne ? .green : .blue
        squareBackground = selected ? selectionColor : .yellow
        textBackground = selected ? .white : .black
        self.gameSettings.selectedTurnLetters.append(blockLetter)
    }
    
    /**
     getLetter()->String: return a letter to display from the model's list of letters
     */
    func getLetter() -> String {
        return gameModel.boardLetters.shuffled()[0]
    }
}

struct GameSquare_Previews: PreviewProvider {
    static var previews: some View {
        GameSquare(gameModel: GameModel()).environmentObject(GameSettings())
    }
}
