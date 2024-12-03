//
//  DashboardAppBar.swift
//  SwiftfulThinkingApp
//
//  Created by Abner Lawrence Baluyut on 12/2/24.
//

import SwiftUI

struct DashboardAppBar: View {
    
    @State var searchText: String = "" 
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(
                alignment: .leading,
                spacing: 30.0
            ) {
                VStack(
                    alignment: .leading,
                    spacing: 6.0
                ) {
                    Text("Location")
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundColor(.gray)
                    HStack {
                        Text("Angeles, Pampanga")
                            .font(.system(size: 18))
                            .fontWeight(.regular)
                            .foregroundColor(AppColors.lightGray)
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 50)
                HStack(
                    alignment: .center
                ) {
                    HStack {
                        Image("search")
                            .resizable()
                            .frame(width: 20, height: 20)
                        TextField(
                            "Search Coffee",
                            text: $searchText,
                            prompt: Text("Search Coffee")
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundStyle(.gray)
                        )
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundStyle(.white)
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(
                                colors:[
                                    Color(hex: "2A2A2A").opacity(0.1),
                                    Color(hex: "2A2A2A").opacity(0.8)
                                ]
                            ),
                            startPoint: .leading, // Starting from left
                            endPoint: .trailing // Ending at right
                        )
                    )
                    .cornerRadius(16)
                    Button(
                        action: {
                        
                        }
                    ) {
                        Image("settings")
                            .resizable()
                            .frame(width: 28, height: 28)
                    }
                    .padding()
                    .frame(
                        width: 54,
                        height: 54,
                        alignment: .center
                    )
                    .background(AppColors.brown)
                    .cornerRadius(12)
                    .padding(.leading, 12)
                }
                .padding(.horizontal, 16)
            }
            .padding()
            .padding(.bottom, 80)
            ZStack {
                AppColors.brown.cornerRadius(10)
                Text("Buy one get one FREE")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(height: 120)
            .padding(.horizontal, 16)
            .offset(y: 50)
        }
        .background(.black)
    }
}

#Preview {
    DashboardAppBar()
}
