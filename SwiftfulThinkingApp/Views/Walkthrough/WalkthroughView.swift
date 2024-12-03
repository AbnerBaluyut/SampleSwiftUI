//
//  WalkthroughView.swift
//  SwiftfulThinkingApp
//
//  Created by Abner Lawrence Baluyut on 12/3/24.
//

import SwiftUI

struct WalkthroughView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack {
                    Image("coffee_bg")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(height: geometry.size.height / 1.8)
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: geometry.size.height)
                        .shadow(
                            color: .black,
                            radius: 10.0,
                            x: 0,
                            y: -20
                        )
                }
            }
            VStack(
                alignment: .center,
                spacing: 24.0
            ) {
                Spacer()
                Text("Fall in Love with Coffee in Blissful Delight!")
                    .font(.system(size: 34.0))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30.0)
                Text("Welcome to our cozy coffee corner, where every cup is a delightfull for you.")
                    .foregroundStyle(.gray)
                    .font(.system(size: 16.0))
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24.0)
                Button(
                    action: {
//                        AppStorageManager.shared.hasSeenWalkthrough = true
                        coordinator.push(page: .dashboard)
                    }
                ) {
                    Text("Get Started")
                        .font(.system(size: 16.0))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(
                            .vertical, 16
                        )
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                }
                .buttonStyle(.borderless)
                .background(AppColors.brown)
                .cornerRadius(16.0)
                .padding(.top, 14.0)
            }
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    WalkthroughView()
}
