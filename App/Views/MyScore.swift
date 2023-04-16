//
//  SwiftUIView.swift
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
    @State private var selectedColor: Color = .blue
    @State private var selectedImg: PhotosPickerItem? = nil
    @State private var selectedColorIndex: Int = 0
    private var colors: [Color] = [.blue,.green,.red,.yellow,.purple,.cyan,.mint]

    var body: some View {
        NavigationView {
            VStack {
                PointsCard(backgroundColor: selectedColor, points: taskList.studentPoints)
                
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
                
                ShareLink(item: Image(uiImage: ImageRenderer(content: PointsCard(backgroundColor: selectedColor, points: taskList.studentPoints)).uiImage!), preview: SharePreview("TEST", image: Image(uiImage: ImageRenderer(content: PointsCard(backgroundColor: selectedColor, points: taskList.studentPoints)).uiImage!)))

                Spacer()
            }.navigationTitle("Points")
        }
    }
}

@available(iOS 16.0, *)
struct MyScoreView_Previews: PreviewProvider {
    static var previews: some View {
        let taskList = TaskList(studentPoints: 50)
        MyScoreView().environmentObject(taskList)
    }
}
