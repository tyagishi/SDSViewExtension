//
//  ContentView.swift
//
//  Created by : Tomoaki Yagishita on 2022/01/23
//  © 2022  SmallDeskSoftware
//

import SwiftUI
import SDSViewExtension

struct ContentView: View {
    let size = CGSize(width: 200, height: 200)
    var body: some View {
        VStack {
            Text("Convenient View Modifiers").font(.title)
            Text("Token Text").token(borderColor: .red)
            Rectangle().fill(.yellow).frame(size)
                .overlay(Text("frame with using CGSize"))
        }
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
