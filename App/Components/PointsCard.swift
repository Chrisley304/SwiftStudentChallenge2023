//
//  SwiftUIView.swift
//  
//
//  Created by Christian Leyva on 16/04/23.
//

import SwiftUI
import PhotosUI

@available(iOS 16.0, *)
struct PointsCard: View {
    
    var backgroundColor: Color
    let points: Int
    @State private var userImg: Image = Image("Placeholder")
    @State private var selectedImg: PhotosPickerItem? = nil
    @State private var userName: String = "Write your name here!"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(backgroundColor)
            VStack {
                Spacer()
                Text("StudyCompa 📓").font(.largeTitle)
                Spacer()
                
                userImg
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(alignment: .bottomTrailing) {
                        PhotosPicker(selection: $selectedImg,
                                     matching: .images,
                                     photoLibrary: .shared()) {
                            Image(systemName: "pencil.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 30))
                                .foregroundColor(.gray)
                        }
//                                     .onChange(of: selectedImg) { newImg in
//                                         Task {
//                                             if let data = try? await newImg?.loadTransferable(type: Image.self) {
//                                                 userImg = data
//                                             }
//                                         }
//                                     }
                                     .buttonStyle(.borderless)
                    }
                
                TextField("", text: $userName).font(.title).multilineTextAlignment(.center)
                Spacer()
                
                Text(String(points))
                    .font(.system(size: 75))
                Text("points").font(.title)
                Spacer()
                Spacer()
            }
        }.frame(width: .infinity, height: 450).padding()
    }
}


@available(iOS 16.0, *)
struct PointsCard_Previews: PreviewProvider {
    static var previews: some View {
        PointsCard(backgroundColor: .blue, points: 50)
    }
}
