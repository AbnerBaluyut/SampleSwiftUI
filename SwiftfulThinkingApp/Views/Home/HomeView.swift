//
//  HomeView.swift
//  SwiftfulThinkingApp
//
//  Created by Abner Lawrence Baluyut on 12/3/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    
    @Namespace private var animation
    
    @State private var headerOffsets: (CGFloat, CGFloat) = (0,0)
    @State private var activeTypeIndex: Int? = 0
    
    private let types: [String] = ["All Coffee", "Macchiato", "Latte", "Americano"]
    private let sampleData = Array(1...5).map { "Item \($0)" }
    
    // MARK: Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            PinnedHeader()
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                ScrollViewReader { proxy in
                    Section {
                        PaginatedView(proxy: proxy)
                    } header: {
                        PinnedTabs(proxy: proxy)
                            .background(AppColors.lightGray)
                            .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
                            .modifier(OffsetModifier(offset: $headerOffsets.0, returnFromStart: false))
                            .modifier(OffsetModifier(offset: $headerOffsets.1))
                    }
                }
            }
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
    
    // MARK: Paginated View
    @ViewBuilder
    func PaginatedView(proxy: ScrollViewProxy) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Group {
                    ForEach(types.indices, id: \.self) { index in
                        GridView()
                            .padding(.top, 20)
                            .padding(.bottom, 70)
                            .padding(.horizontal, 24)
                            .transaction({ transaction in
                                transaction.animation = nil
                            })
                            .id(index)
                    }
                }
                .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
            }
            .scrollTargetLayout(isEnabled: true)
        }
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $activeTypeIndex)
        .scrollIndicators(.never)
        .onChange(of: activeTypeIndex ?? 0) { oldValue, newValue in
            withAnimation(.easeInOut) {
                activeTypeIndex = newValue
                proxy.scrollTo(newValue, anchor: .center)
            }
        }
    }
    
    // MARK: Grid View
    @ViewBuilder
    func GridView() -> some View {
        
        let grid = GridItem(.flexible(), spacing: 14)
        
        LazyVGrid(columns: [grid, grid], spacing: 14) {
            ForEach(sampleData, id: \.self) { item in
                ItemCell()
                    .padding(.all, 14)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .onTapGesture {
                        print("TAPPED PUTA")
                    }
            }
        }
    }
    
    // MARK: Item Cell
    @ViewBuilder
    func ItemCell() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Image("coffee_bg")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .frame(height: 140)
                    .frame(maxWidth: .infinity)
                HStack(spacing: 8) {
                    Image(systemName:"star.fill")
                        .foregroundColor(.yellow)
                        .frame(width: 16, height: 16)
                    Text("4.8")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
                .padding(.top, 8)
                .padding(.trailing, 10)
            }
            Spacer()
            Text("Cafe Mocha")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            Spacer(minLength: 4)
            Text("Deep Foam")
                .font(.system(size: 14))
                .fontWeight(.regular)
                .foregroundStyle(.gray)
            Spacer(minLength: 20)
            HStack(alignment: .center) {
                Text("$4.56")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                Spacer()
                Button(
                    action: {
                        
                    }
                ) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.white)
                }
                .padding()
                .frame(
                    width: 40,
                    height: 40,
                    alignment: .center
                )
                .background(AppColors.brown)
                .cornerRadius(12)
                .padding(.leading, 12)
            }
        }
    }
    
    // MARK: Pinned Tabs
    @ViewBuilder
    private func PinnedTabs(proxy: ScrollViewProxy) -> some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(types.indices, id: \.self) { index in
                    ZStack {
                        if activeTypeIndex == index {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(AppColors.brown)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        } else {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.clear)
                        }
                        Text(types[index])
                            .padding(.horizontal, 18)
                            .padding(.vertical, 14)
                            .fontWeight(activeTypeIndex == index ? .semibold : .regular)
                            .foregroundStyle(activeTypeIndex == index ? .white : .black)
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            activeTypeIndex = index
                            proxy.scrollTo(activeTypeIndex, anchor: .center)
                        }
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 10)
            .padding(.bottom, 4)
        }
        .animation(.easeInOut, value: activeTypeIndex)
    }
    
    // MARK: Pinned Location
    @ViewBuilder
    private func PinnedLocation() -> some View {
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
    
    // MARK: Pinned Search Field w/ Settings
    @ViewBuilder
    private func PinnedSearchFieldWithSettings() -> some View {
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
                    PinnedLocation()
                    PinnedSearchFieldWithSettings()
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
    
    // MARK: Banner
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
