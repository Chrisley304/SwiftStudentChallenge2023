import SwiftUI

struct StoryView: View {
    var body: some View {
        /*#-code-walkthrough(StoryView.starterCode)*/
        /*#-code-walkthrough(StoryView.scrollView)*/
        ScrollView {
            /*#-code-walkthrough(StoryView.scrollView)*/
            VStack(alignment: .leading) {
                /*#-code-walkthrough(StoryView.intro)*/
                /*#-code-walkthrough(StoryView.group)*/
                Text("Your Story")
                    .font(.largeTitle)
                Text("Your Name")
                /*#-code-walkthrough(StoryView.intro)*/
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                //#-learning-task(trustYourVoice)
                /*#-code-walkthrough(StoryView.group)*/
                /*#-code-walkthrough(StoryView.story)*/
                
                /*#-code-walkthrough(StoryView.story)*/
                /*#-code-walkthrough(StoryView.image)*/
                
                /*#-code-walkthrough(StoryView.image)*/
                /*#-code-walkthrough(StoryView.highlight)*/
                
                /*#-code-walkthrough(StoryView.highlight)*/
                
            }
            /*#-code-walkthrough(StoryView.modifiers)*/
            .padding()
            .frame(maxWidth: .infinity)
            .background(in: RoundedRectangle(cornerRadius: 15))
            .padding()
            
            /*#-code-walkthrough(StoryView.secondArticle)*/
            
            /*#-code-walkthrough(StoryView.secondArticle)*/
        }
        .background(Image("Purple").opacity(0.5))
        /*#-code-walkthrough(StoryView.modifiers)*/
        /*#-code-walkthrough(StoryView.starterCode)*/
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
