//
//  ContentModel.swift
//  Learning-SwiftUI
//
//  Created by Alan Liu on 2023/04/18.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    
    // Current Lesson
    @Published var currentLesson: Module.Content.Lesson?
    var currentLessonIndex = 0
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    // MARK: - Data methods
    func getLocalData() {
        // Data
        guard let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json") else { return }
        
        do {
            let jsonData = try Data(contentsOf: jsonUrl)
            let decoder = JSONDecoder()
            let modules = try decoder.decode([Module].self, from: jsonData)
            self.modules = modules
        }
        catch {
            print("Couldn't parse local data")
        }
        
        // Style
        guard let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html") else { return }
        
        do {
            styleData = try Data(contentsOf: styleUrl)
        }
        catch {
            print("Couldn't parse local data")
        }
    }
    
    
    // MARK: - Module navigation methods
    func beginModule(_ moduleId: Int) {
        guard let index = modules.firstIndex(where: { $0.id == moduleId }), modules.indices.contains(index) else {
            currentModule = nil
            return
        }
                
        currentModule = modules[index]
    }
    
    func beginLesson(_ lessonIndex: Int) {
        currentLessonIndex = lessonIndex
        
        guard let currentModule, currentModule.content.lessons.indices.contains(currentLessonIndex) else {
            currentLesson = nil
            currentLessonIndex = 0
            return
        }
        
        currentLesson = currentModule.content.lessons[currentLessonIndex]
    }
    
    func hasNextLesson() -> Bool {
        return currentLessonIndex < (currentModule?.content.lessons.count ?? 0) - 1
    }
    
    func nextLesson() {
        currentLessonIndex += 1
        
        guard let currentModule, currentModule.content.lessons.indices.contains(currentLessonIndex) else {
            currentLesson = nil
            currentLessonIndex = 0
            return
        }
        
        currentLesson = currentModule.content.lessons[currentLessonIndex]
    }
    
    func getNextLessonTitle() -> String {
        guard let currentModule, currentModule.content.lessons.indices.contains(currentLessonIndex + 1) else {
            return ""
        }
        
        return currentModule.content.lessons[currentLessonIndex + 1].title
    }
}
