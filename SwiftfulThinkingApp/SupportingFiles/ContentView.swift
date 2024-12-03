//
//  ContentView.swift
//  SwiftfulThinkingApp
//
//  Created by Abner Lawrence Baluyut on 12/2/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var coordinator = Coordinator()
    private var storageManager = AppStorageManager.shared
        
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: storageManager.hasSeenWalkthrough ? .dashboard : .walkhtrough)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.buildSheet(sheet: sheet)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { item in
                    coordinator.buildCover(cover: item)
                }
        }
        .environmentObject(coordinator)
    }
}
