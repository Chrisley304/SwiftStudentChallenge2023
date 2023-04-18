//
//  IntroPageView.swift
//  
//
//  Created by Christian Leyva on 17/04/23.
//

import SwiftUI

struct IntroPageView: View {
    var page: IntroPage
    
    var body: some View {
        VStack(spacing: 10) {
            VStack {
                Image("\(page.imageUrl)")
                .resizable()
                .scaledToFit()
                .background(.white)
                .cornerRadius(30)
                Text(page.imageAttrib)
                    .font(.footnote).foregroundColor(.gray).multilineTextAlignment(.trailing)
                
            }
            .padding()
            .padding()
            Text(page.name)
                .font(.title).frame(width: 350).multilineTextAlignment(.center)
            
            Text(page.description)
                .font(.subheadline)
                .frame(width: 300)
                .multilineTextAlignment(.center)
        }
    }
}

struct IntroPageView_Previews: PreviewProvider {
    static var previews: some View {
        IntroPageView(page: IntroPage(name: "Welcome to Default App!", description: "The best app to get stuff done on an app.", imageUrl: "students-illustration", imageAttrib: "Attrib test", tag: 0))
    }
}
