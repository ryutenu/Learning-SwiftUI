//
//  RectangleCard.swift
//  Learning-SwiftUI
//
//  Created by Alan Liu on 2023/04/30.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.green
    var height: CGFloat = 48
    
    var body: some View {
        
        Rectangle()
            .cornerRadius(10)
            .foregroundColor(color)
            .frame(height: height)
            .shadow(radius: 5)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
