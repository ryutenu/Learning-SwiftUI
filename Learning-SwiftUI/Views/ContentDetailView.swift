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
            
            if model.hasNextLesson() {
                Button {
                    model.nextLesson()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 45)
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        Text("Next Lesson: \(model.getNextLessonTitle())")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
            .environmentObject(ContentModel())
    }
}
