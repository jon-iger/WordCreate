//
//  GameRow.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/28/22.
//

import SwiftUI

struct GameRow: View {
    let modal: GameModel
    var body: some View {
        HStack(alignment: .center) {
            ForEach(0..<6) { block in
                GameSquare(gameModal: modal)
            }
        }
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(modal: GameModel(currentDateTime: Date()))
    }
}
