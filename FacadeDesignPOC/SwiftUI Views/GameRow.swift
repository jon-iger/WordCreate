//
//  GameRow.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/28/22.
//

import SwiftUI

struct GameRow: View {
    let letterArray: [String]
    var body: some View {
        HStack(alignment: .center) {
            ForEach(letterArray, id: \.self) { block in
                GameSquare(blockLetter: block)
            }
        }
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        GameRow(letterArray: ["A", "B", "C", "D"])
    }
}
