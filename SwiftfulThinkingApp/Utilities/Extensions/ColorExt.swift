//
//  CustomColors.swift
//  SwiftfulThinkingApp
//
//  Created by Abner Lawrence Baluyut on 12/2/24.
//

import SwiftUI

extension Color {
    
    init(hex: String) {

        var hexSanitized = hex
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        // Convert hex string to RGB values
        let scanner = Scanner(string: hexSanitized)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        // Extract the red, green, and blue components
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}