//
//  GameBoard.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/28/22.
//

import SwiftUI

struct GameBoard: View {
    var body: some View {
        VStack(alignment: .center) {
            ForEach(1..<6) { index in
                GameRow(letterArray: ["A", "B", "C", "D", "E"])
            }
            DoneSelect()
                .padding(.top, 15)
                .padding(.bottom, 15)
            Clear()
        }
    }
}

struct GameBoard_Previews: PreviewProvider {
    static var previews: some View {
        GameBoard()
    }
}
