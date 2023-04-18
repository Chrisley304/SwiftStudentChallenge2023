//
//  MyScore.swift
//
//
//  Created by Christian Leyva on 15/04/23.
//

import PhotosUI
import SwiftUI

@available(iOS 16.0, *)
struct MyScoreView: View {
    @State private var userImage: Image = Image("Placeholder")
    @EnvironmentObject var taskList: TaskList
    @State private var selectedColor: Color = .cyan
    @State private var selectedImg: PhotosPickerItem? = nil
    @State private var selectedColorIndex: Int = 0
    @State private var studentName: String = "Write your name here!"
    private var colors: [Color] = [.cyan,.blue,.green,.red,.yellow,.purple,.mint, .pink]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    PointsCard(backgroundColor: selectedColor, points: taskList.studentPoints, userName: $studentName, editMode: true, userImg: $userImage).padding(.horizontal)
                    
                    Button(action: {
                        if selectedColorIndex == (colors.count-1) {
                            selectedColorIndex = 0
                        }else{
                            selectedColorIndex += 1
                        }
                        selectedColor = colors[selectedColorIndex]
                    }) {
                        Text("Change color")
                            .fontWeight(.semibold)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selectedColor)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .padding(.vertical, 16)
                    
                    ShareLink(item: Image(uiImage: ImageRenderer(content: cardImage ).uiImage!), preview: SharePreview("\(studentName) Points Card", image: Image(uiImage: ImageRenderer(content: cardImage).uiImage!)))

                    Spacer()
                }.navigationTitle("My Points").padding(.top, 30)
            }
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    var cardImage: PointsCard{
        return PointsCard(backgroundColor: selectedColor, points: taskList.studentPoints, userName: $studentName, editMode: false, userImg: $userImage, userImgStatic: userImage)
    }
}

@available(iOS 16.0, *)
struct MyScoreView_Previews: PreviewProvider {
    static var previews: some View {
        let taskList = TaskList(studentPoints: 50)
        MyScoreView().environmentObject(taskList)
    }
}
