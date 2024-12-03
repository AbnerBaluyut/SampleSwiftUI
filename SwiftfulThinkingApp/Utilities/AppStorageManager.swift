//
//  AppStoreManager.swift
//  SwiftfulThinkingApp
//
//  Created by Abner Lawrence Baluyut on 12/2/24.
//

import SwiftUI

class AppStorageManager {
    static let shared = AppStorageManager()
    
    private enum Keys {
        static let hasSeenWalkthrough = "hasSeenWalkthrough"
        static let isLoggedIn = "isLoggedIn"
    }
    
    @AppStorage(Keys.hasSeenWalkthrough) var hasSeenWalkthrough: Bool = false
    @AppStorage(Keys.isLoggedIn) var isLoggedIn: Bool = false;
}
