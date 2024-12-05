//
//  DashboardViewModel.swift
//  SwiftfulThinkingApp
//
//  Created by Abner Lawrence Baluyut on 12/2/24.
//

import SwiftUI

class DashboardViewModel: ObservableObject {
    
    private var appStorage = AppStorageManager.shared
    
    @Published var searchText: String = ""
    @Published var selectedTab: Int = 0
    
    func clearAppStorage() {
        appStorage.hasSeenWalkthrough = false
    }
}
