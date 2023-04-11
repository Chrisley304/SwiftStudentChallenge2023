//
//  SwiftUIView.swift
//  
//
//  Created by Christian Leyva on 10/04/23.
//

import SwiftUI

struct ColorCard: View {
    let color: Color
    let title: String
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(color)
            
            VStack {
                Spacer()
                Text(title).font(.caption)
                Spacer()
                Text(text).font(.title)
                Spacer()
            }
        }.frame(width: 130, height: 130)
    }
}

struct ColorCard_Previews: PreviewProvider {
    static var previews: some View {
        ColorCard(color: Color.cyan, title: "Homeworks finished" ,text: "5")
    }
}
