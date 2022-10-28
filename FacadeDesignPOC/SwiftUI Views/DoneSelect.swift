//
//  DoneSelect.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 10/28/22.
//

import SwiftUI

struct DoneSelect: View {
    var body: some View {
        Button(action: {
            print("Hi there")
        }) {
            Text("Done")
                .font(.title)
                .frame(width: 110, height: 20)
                .padding(15)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(15)
        }
    }
}

struct DoneSelect_Previews: PreviewProvider {
    static var previews: some View {
        DoneSelect()
    }
}
