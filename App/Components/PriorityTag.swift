//
//  SwiftUIView.swift
//  
//
//  Created by Christian Leyva on 12/04/23.
//

import SwiftUI

struct PriorityTag: View {
    var color:Color
    var priorityTitle: String
    var textColor:Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35).fill(color)
            
            VStack {
                Spacer()
                Text(priorityTitle).font(.caption).foregroundColor(textColor)
                Spacer()
            }
        }.frame(width: 85, height: 30)
    }
}

struct PriorityTag_Previews: PreviewProvider {
    static var previews: some View {
        PriorityTag(color: Color(.red), priorityTitle: "Prueba", textColor: .white)
    }
}
