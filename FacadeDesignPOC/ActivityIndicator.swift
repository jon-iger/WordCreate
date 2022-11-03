//
//  ActivityIndicator.swift
//  FacadeDesignPOC
//
//  Created by Jonathon Lannon on 11/2/22.
//

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    
    @Binding var animate: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.startAnimating()
    }
}

struct HiddenIndicator: View {
    var hiddenStatus: Bool
    @State var bindStatus: Bool = true
    var body: some View {
        if hiddenStatus {
            VStack {
                Text("Loading").hidden()
                    .font(.title)
                    .foregroundColor(.white)
                ActivityIndicator(animate: $bindStatus).hidden()
            }
            .frame(width: 300, height: 300, alignment: .center)
            .background(.black)
            .cornerRadius(15)
        } else {
            VStack {
                Text("Loading")
                    .font(.title)
                    .foregroundColor(.white)
                ActivityIndicator(animate: $bindStatus)
            }
            .frame(width: 300, height: 300, alignment: .center)
            .background(.black)
            .cornerRadius(15)
        }
    }
}
