//
//  SwiftUIView.swift
//
//
//  Created by Christian Leyva on 17/04/23.
//

import SwiftUI

struct IntroView: View {
    @Binding var isShown: Bool

    @State private var pageIndex = 0
    private let pages: [IntroPage] = [
        IntroPage(name: "Welcome to StudyCompa!", description: "The best companition app for the Students!", imageUrl: "students-illustration", imageAttrib: "Illustration obtained from: IconScout Free Startup Illustration Pack", tag: 0),
        IntroPage(name: "Organize your homeworks", description: "Add your homeworks to the app and WIN POINTS by accomplish them. You get 10 points for each homework and if you accomplish a homework before it's due date you get 5 extra points for each extra day!", imageUrl: "planning-man-illustration", imageAttrib: "Illustration obtained from: IconScout Free Startup Illustration Pack", tag: 1),
        IntroPage(name: "Get fun!", description: "With the points that you win in the app you can unlock diferent games.", imageUrl: "man-rocket-illustration", imageAttrib: "Illustration obtained from: IconScout Free Startup Illustration Pack", tag: 2),
        IntroPage(name: "Show your points!", description: "Modify your StudyCompa card with your name & photo and share it with your friends!", imageUrl: "woman-goal-illustration", imageAttrib: "Illustration obtained from: IconScout Free Startup Illustration Pack", tag: 3),
    ]
    private let dotAppearance = UIPageControl.appearance()

    var body: some View {
        TabView(selection: $pageIndex) {
            ForEach(pages) { page in
                ZStack {
                    Button(action: {
                        isShown.toggle()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.gray)
                    }
                    .position(x: UIScreen.main.bounds.width - 30, y: 30)
                    VStack {
                        Spacer()
                        IntroPageView(page: page)
                        Spacer()
                        if page == pages.last {
                            Button {
                                isShown.toggle()
                            } label: {
                                Text("Lets get started!").bold().padding(.horizontal, 40).padding(.vertical, 10)
                            }.buttonStyle(.borderedProminent)
                        } else {
                            Button(action: incrementPage) {
                                Text("Next").padding(.horizontal, 40).padding(.vertical, 10)
                            }
                            .buttonStyle(.bordered)
                        }
                        Spacer()
                        Spacer()
                    }
                    
                }.tag(page.tag)
            }
        }
        .animation(.easeInOut, value: pageIndex) // 2
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            dotAppearance.currentPageIndicatorTintColor = .blue
            dotAppearance.pageIndicatorTintColor = .gray
        }
    }

    func incrementPage() {
        pageIndex += 1
    }

    func goToZero() {
        pageIndex = 0
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(isShown: .constant(true))
    }
}
