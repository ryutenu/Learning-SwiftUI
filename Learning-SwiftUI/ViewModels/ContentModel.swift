//
//  ContentModel.swift
//  Learning-SwiftUI
//
//  Created by Alan Liu on 2023/04/18.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
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
}
