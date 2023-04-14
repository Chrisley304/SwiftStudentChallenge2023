//
//  SwiftUIView.swift
//  
//
//  Created by Christian Leyva on 13/04/23.
//

import SwiftUI

struct HomeworkModalCard: View {
    
    var title: String
    var homeworkClass : HomeworkClass
    @Binding public var showHomeworkModal: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(homeworkClass.color).frame(width: 300, height: 200)
            
            VStack {
                Spacer()
                Text("💡 You can start with:").foregroundColor(homeworkClass.textColor).font(.title3)
                Spacer()
                VStack{
                    Text(title).font(.largeTitle).foregroundColor(homeworkClass.textColor).bold()
                    Text(homeworkClass.title).font(.title2).foregroundColor(homeworkClass.textColor)
                }
                Spacer()
                Spacer()
            }.frame(width: 300, height: 200)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black.opacity(0.6))
            .onTapGesture {
                showHomeworkModal.toggle()
            }
        
    }
}

struct HomeworkModalCard_Previews: PreviewProvider {
    static var previews: some View {
        HomeworkModalCard(title: "Equations", homeworkClass: HomeworkClass(id: 0, title: "Math 📏", color: .blue, textColor: .white), showHomeworkModal: .constant(true))
    }
}
