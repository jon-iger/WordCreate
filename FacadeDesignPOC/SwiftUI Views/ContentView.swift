//
//  ContentView.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/26/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center) {
            GameBoard()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
