//
//  DashoardView.swift
//  SwiftfulThinkingApp
//
//  Created by Abner Lawrence Baluyut on 12/2/24.
//

import SwiftUI

struct DashoardView: View {
    
    @StateObject private var viewModel = DashboardViewModel()
    
    @Namespace var animation: Namespace.ID
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MainContent()
            NavigationTabBar()
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.container, edges: .bottom)
        
    }
    
    // MARK: Content based on the selected tab
    @ViewBuilder
    private func MainContent() -> some View {
        Group {
            switch viewModel.selectedTab {
                case 0: HomeView()
                case 1: Text("Search Screen").font(.largeTitle)
                case 2: Text("Profile Screen").font(.largeTitle)
                default: Text("More Screen").font(.largeTitle)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: Tab Bar
    @ViewBuilder
    private func NavigationTabBar() -> some View {
        HStack(alignment: .center) {
            Spacer()
            TabButton(
                index: 0,
                image: "house.fill",
                title: "Home",
                animation: animation,
                selectedTab: $viewModel.selectedTab
            )
            Spacer()
            TabButton(
                index: 1,
                image: "heart",
                title: "Favorites",
                animation: animation,
                selectedTab: $viewModel.selectedTab
            )
            Spacer()
            TabButton(
                index: 2,
                image: "bag",
                title: "Cart",
                animation: animation,
                selectedTab: $viewModel.selectedTab
            )
            Spacer()
            TabButton(
                index: 3,
                image: "bell",
                title: "Alerts",
                animation: animation,
                selectedTab: $viewModel.selectedTab
            )
            Spacer()
        }
        .frame(height: 60)
        .padding(.vertical, 10)
        .background(
            Color.white
                .clipShape(RoundedCorner(corners: [.topLeft, .topRight], radius: 30))
                .shadow(color: .black.opacity(0.1), radius: 5.0, x: 0)
        )
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    DashoardView()
}

