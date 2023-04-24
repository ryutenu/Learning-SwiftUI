//
//  ContentView.swift
//  Learning-SwiftUI
//
//  Created by Alan Liu on 2023/04/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                if let module = model.currentModule {
                    ForEach(module.content.lessons.indices, id: \.self) { index in
                        
                        let lesson = module.content.lessons[index]
                        
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .frame(height: 65)
                            
                            HStack(spacing: 30) {
                                Text(String(index + 1))
                                    .bold()
                                
                                VStack(alignment: .leading) {
                                    Text(lesson.title)
                                        .bold()
                                    
                                    Spacer()
                                    
                                    Text(lesson.duration)
                                }
                            }
                            .padding()
                        }
                        .padding(.bottom, 5)
                    }
                }
            }
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentModel())
    }
}
