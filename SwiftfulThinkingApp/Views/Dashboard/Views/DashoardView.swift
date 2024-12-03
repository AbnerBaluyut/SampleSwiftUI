//
//  DashoardView.swift
//  SwiftfulThinkingApp
//
//  Created by Abner Lawrence Baluyut on 12/2/24.
//

import SwiftUI

struct DashoardView: View {
    
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HeaderView()
            CardView()
            VStack {
                Text("Dashboard App Bar")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                Text("Collapsing App Bar")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.top, 10)
                Spacer()
            }
            .padding(.top, 20)
        }
        .ignoresSafeArea(.all, edges: .top)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color.white)
        .navigationBarBackButtonHidden()
    }
    
    
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader { geo in
            let minY = geo.frame(in: .global).minY
            let isScrolling = minY > 0
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
                    HStack(
                        alignment: .center
                    ) {
                        HStack {
                            Image("search")
                                .resizable()
                                .frame(width: 20, height: 20)
                            TextField(
                                "Search Coffee",
                                text: $viewModel.searchText,
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
                                startPoint: .leading,
                                endPoint: .trailing
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
            }
            .frame(height: isScrolling ? 300 + minY : 300)
            .background(.black)
            .offset(y: isScrolling ? -minY : 0)
        }
        .frame(height: 250)
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func CardView() -> some View {
        ZStack {
            AppColors.brown.cornerRadius(10)
            Text("Buy one get one FREE")
                .font(.headline)
                .bold()
                .foregroundColor(.white)
                .padding()
        }
        .frame(height: 100)
        .padding(.horizontal, 16)
    }
}

#Preview {
    DashoardView()
}

