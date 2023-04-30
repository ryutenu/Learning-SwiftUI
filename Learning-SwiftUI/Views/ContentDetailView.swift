//
//  ContentDetailView.swift
//  Learning-SwiftUI
//
//  Created by Alan Liu on 2023/04/25.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        
        VStack {
            if let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? "")) {
                VideoPlayer(player: AVPlayer(url: url))
                    .cornerRadius(10)
            }
            
            // Description
            CodeTextView()
            
            Button {
                model.hasNextLesson() ? model.nextLesson() : print("Complete")
            } label: {
                ZStack {
                    RectangleCard()
                    
                    Text(model.hasNextLesson() ? "Next Lesson: \(model.getNextLessonTitle())" : "Complete")
                        .foregroundColor(.white)
                        .bold()
                }
            }
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
            .environmentObject(ContentModel())
    }
}
