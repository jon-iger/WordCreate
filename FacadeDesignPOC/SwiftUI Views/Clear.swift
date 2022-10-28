//
//  Clear.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/28/22.
//

import SwiftUI

struct Clear: View {
    var body: some View {
        Button(action: {
            print("Hi there")
        }) {
            Text("Clear")
                .font(.title)
                .frame(width: 110, height: 20)
                .padding(15)
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(15)
        }
    }
}

struct Clear_Previews: PreviewProvider {
    static var previews: some View {
        Clear()
    }
}
