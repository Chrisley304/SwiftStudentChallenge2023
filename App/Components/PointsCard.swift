//
//  SwiftUIView.swift
//
//
//  Created by Christian Leyva on 16/04/23.
//

import PhotosUI
import SwiftUI

@available(iOS 16.0, *)
struct PointsCard: View {
    var backgroundColor: Color
    let points: Int
    @Binding public var userName: String
    let editMode: Bool
    @Binding public var userImg: Image
    var userImgStatic: Image = Image("Placeholder")
    
    @State private var selectedImg: PhotosPickerItem? = nil
    @State private var avatarItem: PhotosPickerItem?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(backgroundColor)
            VStack {
                Spacer()
                Text("StudyCompa 📓").font(.largeTitle)
                Spacer()

                if editMode{
                    userImg
                    .resizable()
                    .frame(width: 120, height: 120)
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(alignment: .bottomTrailing) {
                        
                            PhotosPicker(selection: $avatarItem,
                                         matching: .images) {
                                Image(systemName: "pencil.circle.fill")
                                    .symbolRenderingMode(.multicolor)
                                    .font(.system(size: 30))
                                    .foregroundColor(.gray)
                                    .buttonStyle(.borderless)
                            }
                        
                    }
                }else{
                    userImgStatic
                        .resizable()
                        .frame(width: 120, height: 120)
                        .scaledToFill()
                        .clipShape(Circle())
                }
                if editMode {
                    TextField("", text: $userName).font(.title).multilineTextAlignment(.center)
                        .submitLabel(.done)
                        .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                            if let textField = obj.object as? UITextField {
                                textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                            }
                        }
                } else {
                    Text(userName).font(.title).multilineTextAlignment(.center)
                }
                Spacer()

                Text(String(points))
                    .font(.system(size: 75))
                Text("points").font(.title)
                Spacer()
                Spacer()
            }.onChange(of: avatarItem) { _ in
                Task {
                    if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            userImg = Image(uiImage: uiImage)
                            return
                        }
                    }
                }
            }
        }.frame( width: 350 , height: 450)
    }
}

@available(iOS 16.0, *)
struct PointsCard_Previews: PreviewProvider {
    static var previews: some View {
        PointsCard(backgroundColor: .red, points: 50, userName: .constant("Put your name here!"), editMode: true, userImg: .constant(Image("Placeholder")))
    }
}
