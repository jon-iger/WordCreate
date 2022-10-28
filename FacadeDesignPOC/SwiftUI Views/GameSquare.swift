//
//  GameSquare.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/28/22.
//

import SwiftUI

struct GameSquare: View {
    let blockLetter: String
    var body: some View {
        ZStack(alignment: .center){
            Rectangle()
                .foregroundColor(.yellow)
                .frame(width: 50, height: 50)
                .border(.black)
            Text(blockLetter)
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

struct GameSquare_Previews: PreviewProvider {
    static var previews: some View {
        GameSquare(blockLetter: "A")
    }
}
