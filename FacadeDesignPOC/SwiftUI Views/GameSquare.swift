//
//  GameSquare.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/28/22.
//

import SwiftUI

struct GameSquare: View {
    @EnvironmentObject var currentLetters: GameSettings
    let gameModal: GameModel
    @State var blockLetter = String()
    @State var selected = false
    @State var squareBackground = Color.yellow
    @State var textBackground = Color.black
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
                        blockLetter = getLetter()
                    }
            }
        }
    }
    func squareTap() {
        selected.toggle()
        let selectionColor: Color = currentLetters.isPlayerOne ? .green : .blue
        squareBackground = selected ? selectionColor : .yellow
        textBackground = selected ? .white : .black
        self.currentLetters.selectedTurnLetters.append(blockLetter)
    }
    
    func getLetter() -> String {
        return gameModal.boardLetters.shuffled()[0]
    }
}

struct GameSquare_Previews: PreviewProvider {
    static var previews: some View {
        GameSquare(gameModal: GameModel()).environmentObject(GameSettings())
    }
}
