//
//  GameRow.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon
//  File created to hold a single horizontal row of letter blocks to display
//

import SwiftUI

struct GameRow: View {
    let modal: GameModel    // model taken as a parameter to be passed along to the block to be displayed on the board
    var body: some View {
        HStack(alignment: .center) {
            ForEach(0..<6) { block in
                GameSquare(gameModel: modal)
            }
        }
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(modal: GameModel())
    }
}
