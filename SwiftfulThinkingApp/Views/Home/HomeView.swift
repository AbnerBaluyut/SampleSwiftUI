//
//  HomeView.swift
//  SwiftfulThinkingApp
//
//  Created by Abner Lawrence Baluyut on 12/3/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    @State var currentType: String = "Popular"
    
    // MARK: For Smooth Sliding Effect
    @Namespace var animation
    
    @State var headerOffsets: (CGFloat, CGFloat) = (0,0)
    
    private let types: [String] = ["Popular", "Brown", "Songs", "Fans", "About", "Coffee", "Ice Cream"]
    private let sampleData = Array(1...50).map { "Item \($0)" }
    
    @State private var height: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            PinnedHeader()
//            ScrollViewReader { proxy in
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        ForEach(types, id: \.self) { type in
                            if currentType == type {
                                VStack(alignment: .leading) {
                                    Text("\(type) Content")
                                        .font(.headline)
                                    ForEach(sampleData, id: \.self) { item in
                                        Text("Item \(item)")
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .cornerRadius(10)
                                    }
                                }
                                .padding()
                            }
                        }
                        
                    } header: {
                        PinnedTabs(/*proxy: proxy*/)
                            .background(AppColors.lightGray)
                            .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
                            .modifier(OffsetModifier(offset: $headerOffsets.0, returnFromStart: false))
                            .modifier(OffsetModifier(offset: $headerOffsets.1))
                    }
                }
//            }
        }
        .overlay(content: {
            Rectangle()
                .fill(AppColors.lightGray)
                .frame(height: 50)
                .frame(maxHeight: .infinity, alignment: .top)
                .opacity(headerOffsets.0 < 8 ? 1 : 0)
        })
        .coordinateSpace(name: "SCROLL")
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea(.container, edges: .vertical)
        .background(AppColors.lightGray)
    }
    
    // MARK: Random List
    @ViewBuilder
    func GridView() -> some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1)], spacing: 1) {
            ForEach(0...100, id: \.self) { index in
                Text("HELLO")
                    .padding()
            }
        }
        .background(
            GeometryReader { geo in
                Color.clear
                    .preference(
                        key: HeightPreferenceKey.self,
                        value: geo.size.height
                    )
            }
            .onPreferenceChange(HeightPreferenceKey.self) { height in
                self.height = height
            }
        )
    }
    
    // MARK: Pinned Tabs
    @ViewBuilder
    private func PinnedTabs(/*proxy: ScrollViewProxy*/) -> some View {
        
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(types, id: \.self) { type in
                        ZStack {
                            if currentType == type {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(AppColors.brown)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            } else {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.clear)
                            }
                            Text(type)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 14)
                                .fontWeight(currentType == type ? .semibold : .regular)
                                .foregroundStyle(currentType == type ? .white : .black)
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                currentType = type
                                proxy.scrollTo(type, anchor: .center)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
            }
        }
    }
    
    // MARK: Location
    @ViewBuilder
    private func Location() -> some View {
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
    }
    
    // MARK: Search Field
    @ViewBuilder
    private func SearchFieldWithSettings() -> some View {
        HStack(
            alignment: .center
        ) {
            HStack {
                Image("search")
                    .resizable()
                    .frame(width: 20, height: 20)
                TextField(
                    "",
                    text: $viewModel.searchText,
                    prompt: Text("Search Coffee")
                        .font(.system(size: 16))
                        .fontWeight(.regular)
                        .foregroundStyle(.gray)
                )
                .padding(.horizontal, 8)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .foregroundStyle(.white)
                .frame(height: 55)
            }
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
    }
    
    // MARK: Pinned Header
    @ViewBuilder
    private func PinnedHeader() -> some View {
        VStack {
            GeometryReader { geo in
                let minY = geo.frame(in: .global).minY
                let isScrolling = minY > 0
                VStack(
                    alignment: .leading,
                    spacing: 30.0
                ) {
                    Location()
                    SearchFieldWithSettings()
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
                .frame(height: isScrolling ? 300 + minY : 300)
                .background(.black)
                .offset(y: isScrolling ? -minY : 0)
            }
            .frame(height: 400)
            .padding(.bottom, -180)
            .ignoresSafeArea()
            BannerView()
        }
    }
    
    @ViewBuilder
    private func BannerView() -> some View {
        Image("banner")
            .resizable()
            .padding(.horizontal, 24)
            .frame(height: 140)
    }
}

#Preview {
    HomeView()
}


struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
