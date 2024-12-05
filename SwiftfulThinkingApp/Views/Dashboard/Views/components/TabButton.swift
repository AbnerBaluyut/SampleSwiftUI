//
//  TabButton.swift
//  SwiftfulThinkingApp
//
//  Created by Abner Lawrence Baluyut on 12/4/24.
//

import SwiftUI

struct TabButton: View {
    let index: Int
    let image: String
    let title: String
    let animation: Namespace.ID
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(spacing: 4) {
            // Tab icon
            Image(systemName: image)
                .font(.system(size: selectedTab == index ? 26 : 24))
                .foregroundColor(selectedTab == index ? AppColors.brown : .gray)
            // Indicator (display only for the selected tab)
            ZStack {
                if selectedTab == index {
                    Capsule()
                    .fill(AppColors.brown)
                    .frame(width: 15, height: 6)
                    .offset(y: 5)
                    .matchedGeometryEffect(id: "TAB", in: animation)
                } else {
                    Capsule()
                    .fill(.clear)
                    .frame(width: 15, height: 6)
                    .offset(y: 5)
                }
             }
        }
        .padding(.vertical, 8)
        .onTapGesture {
            withAnimation(.easeInOut) {
                selectedTab = index
            }
        }
    }
}
