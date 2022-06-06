//
//  CatalogueHomeScreenView.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import SwiftUI
import Introspect

struct CatalogueHomeScreenView<ViewModel: CatalogueHomeViewModel>: View {
    @StateObject var viewModel: ViewModel
    @State var presentingDetailMenu: Bool = false

    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Color.clear
                    //.onAppear(perform: viewModel.load)
            case .loading:
                placeholder().disabled(true)
            case .failed:
                failed()
            case .loaded:
                content()

            case .empty:
                empty()
            }
        }
    }

    @ViewBuilder
    func content() -> some View {
        NavigationView {
            ScrollViewReader { proxy in

                ScrollView {
                    LazyVStack(pinnedViews: [.sectionHeaders]) {
                        parallaxHeaderImage()
                            .id("parallaxHeaderImageId")
                        Section {
                            RoundedRectangle(cornerRadius: 0)
                                .frame(height: 3)
                                .foregroundColor(Color.gray.opacity(0.2))
                                .shadow(color: .black.opacity(0.5), radius: 5, x: -2, y: 2)

                            menuPopular()
                                .padding(.bottom)
                                .padding([.leading, .trailing])
                                .id("menuPopular")

                            menuList()
                                .padding([.leading, .trailing])
                                .id("menuList")

                        } header: {
                            ScrollViewReader { proxyHeader in
                                ScrollView(.horizontal, showsIndicators: false) {
                                    header(proxy: proxy)
                                        .id("header")
                                }.introspectScrollView { scollview in
                                    scollview.bounces = false
                                }.onChange(of: viewModel.selectedCategoy) { newValue in
                                    withAnimation {
                                        proxyHeader.scrollTo(newValue)
                                    }
                                }
                            }
                        }

                    }.background(Color.gray.opacity(0.1))
                }
            }
            .sheet(isPresented: $presentingDetailMenu, onDismiss: nil, content: {
                let service = CatalogueService()
                CatalogueDetailScreenView(viewModel: CatalogueDetailViewModel(service: service))
            })
            .onAppear(perform: {
                viewModel.fetchCatalogueHome()

            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(L10n.homeScreenNavigationTitle.localize)
        }
    }

    @ViewBuilder
    func placeholder() -> some View {
        let mock = CatalogueHomeModel.mock()
        let mockList = mock.list[0]
        NavigationView {
            ScrollView {
                parallaxHeaderImage()
                HStack {
                    ForEach(mockList.items) { item in

                        MenuGridItem(item: item).padding(.bottom)
                    }
                }
                ForEach(mockList.items) { item in

                    MenuRow(item: item)
                }
            }.redacted(reason: .placeholder)
        }
    }

    @ViewBuilder
    func failed() -> some View {
        DialogView(title: L10n.failStateTitle.localize,
                   subtitle: L10n.failStateSubTitle.localize,
                   buttonTitle: L10n.failStateButton.localize) {
            viewModel.load()
        }
    }

    @ViewBuilder
    func empty() -> some View {
        DialogView(title: L10n.emptyStateTitle.localize,
                   subtitle: L10n.emptyStateSubTitle.localize)
    }

    @ViewBuilder
    func parallaxHeaderImage() -> some View {
        GeometryReader { geometry in
            ZStack {
                if geometry.frame(in: .global).minY <= 0 {
                    Image("sushi")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(y: geometry.frame(in: .global).minY / 9)
                        .clipped()
                        
                } else {
                    Image("sushi")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                        .clipped()
                        .offset(y: -geometry.frame(in: .global).minY)
                        
                }
            }
        }
        .frame(height: 100)
        .id(0)
        
    }

    @ViewBuilder
    func header(proxy: ScrollViewProxy) -> some View {
        if let categories = viewModel.data?.categories {
            LazyHStack {
                ForEach(categories) { category in
                    Button {
                        viewModel.selectedCategoy = category.id

                        withAnimation(.easeInOut(duration: 60)) {
                            let index = viewModel.data?.categories.firstIndex(of: category)
                            let iffset = max(Double(index ?? 0) * 0.1, 0.1)
                            let categoryId = index == 0 ? 0 : category.hashValue
                            proxy.scrollTo(categoryId, anchor: UnitPoint(x: UnitPoint.top.x, y: UnitPoint.top.y - max(iffset, 0.05)))
                        }

                    } label: {
                        VStack(spacing: 8) {
                            Text(category.name)
                                .foregroundColor(.primary)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                                .if(category.id != viewModel.selectedCategoy) { view in
                                    view.opacity(0.6)
                                }

                            Rectangle()
                                .fill(Color.blue)
                                .frame(maxWidth: .infinity, maxHeight: 2)
                                .if(category.id != viewModel.selectedCategoy) { view in
                                    view.hidden()
                                }
                        }
                    }.id(category.id)
                }
            }
            .padding(.top, 8)
            .background(Color.tabBarbackground)
        }
    }

    @ViewBuilder
    func menuPopular() -> some View {
        if let list = viewModel.data?.list {
            if let popularCategory = list.first(where: { $0.categoryID == "popular" }) {
                VStack(alignment: .leading) {
                    Text(popularCategory.displayName.capitalized)
                        .foregroundColor(.primary)
                        .font(.body)
                        .fontWeight(.semibold)
                        .onAppear {
                            print(popularCategory.hashValue)
                            viewModel.selectedCategoy = popularCategory.id
                        }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(popularCategory.items) { menu in
                                MenuGridItem(item: menu).padding(.bottom)
                            }
                        }
                    }
                }.onTapGesture {
                    presentingDetailMenu = true
                }.id(popularCategory.hashValue)
            }
        }
    }

    @ViewBuilder
    func menuList() -> some View {
        if let list = viewModel.data?.list {
            ForEach(list[1 ... (list.count - 1)]) { item in
                VStack(alignment: .leading, spacing: 16) {
                    Text(item.displayName.capitalized)
                        .foregroundColor(.primary)
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.bottom, 8)
                        .onAppear {
                            print(item.hashValue)
                            viewModel.selectedCategoy = item.id
                        }

                    ForEach(item.items) { menu in
                        MenuRow(item: menu)
                    }
                }.onTapGesture {
                    presentingDetailMenu = true
                }.id(item.hashValue)
            }
        }
    }
}

struct CatalogueHomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        let service = MockCatalogueService()
        CatalogueHomeScreenView(viewModel: CatalogueHomeViewModel(service: service))
    }
}
