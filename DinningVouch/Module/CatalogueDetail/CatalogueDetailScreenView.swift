//
//  CatalogueDetailScreenView.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import NukeUI
import SwiftUI

struct CatalogueDetailScreenView<ViewModel: CatalogueDetailViewModel>: View {
    @StateObject var viewModel: ViewModel
    @State var onEditing: Bool = false
    @State var notesText: String = ""
    @State var noteCharactersCount: Int = 0
    
    let maxCharactesNotes: Int = 200
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Color.clear
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
        VStack {
            Rectangle().frame(width: 40, height: 5, alignment: .center)
                .foregroundColor(Color.gray)
                .padding(.top, 16)
                .padding(.bottom, 8)
            ScrollView(showsIndicators: false) {
                VStack {
                    header
                    DividerView(height: 6)
                    
                    MenuOptionsView(title: L10n.menuOptionTitle.localize,
                                    placeholder: L10n.menuOptionPlaceholder.localize,
                                    options: variantsTitle)
                        .padding()
                    
                    DividerView(height: 6)
                    topAddOns()
                    
                    DividerView(height: 6)
                    addOnMenus()
                    
                    DividerView(height: 6)
                    notes()
                }
            }
            addToCart
        }
        .onChange(of: viewModel.data, perform: { _ in
            viewModel.calculateTotal()
        })
        .onAppear {
            viewModel.fetchMenuDetails()
        }
    }
    
    @ViewBuilder
    func placeholder() -> some View {
        let mockData = CatalogueDetailViewData.mock()
        VStack {
            Rectangle().frame(width: 40, height: 5, alignment: .center)
                .foregroundColor(Color.gray)
                .padding(.top, 16)
                .padding(.bottom, 8)
            
            ScrollView {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                
                DividerView(height: 6)
                
                MenuOptionsView(title: L10n.menuOptionTitle.localize,
                                placeholder: L10n.menuOptionPlaceholder.localize,
                                options: [])
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("Placeholder")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.primary)
                    
                    ForEach(0 ..< 10, id: \.self) { _ in
                        AddOnRow(item: .constant(mockData.addons[0].addonItems[0]), hideDivider: false)
                    }
                }.padding()
            }
        }.redacted(reason: .placeholder)
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
    
    var header: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                LazyImage(source: viewModel.data.imageURL) { state in
                    if let image = state.image {
                        image
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight: 200)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 200)
                    }
                }
                .cornerRadius(18, corners: [.bottomLeft, .bottomRight])
                .padding(.bottom)
                Text(viewModel.data.name)
                    .font(.callout)
                    .fontWeight(.semibold)
                    
                Text(viewModel.data.catalogueDetailModelDescription)
                    .font(.caption2)
                    .foregroundColor(Color.gray)
                    
                FlexibleView(data: viewModel.data.displayedTags, spacing: 8, alignment: .leading) { value in
                    Text(value)
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.blue.opacity(0.2))
                        )
                }

                HStack {
                    Text("SGD \(viewModel.data.formattedDisplayPrice)")
                        .font(.footnote)
                        .fontWeight(.bold)

                    Text("SGD \(viewModel.data.formattedPrice)")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .strikethrough()
                        .if(!viewModel.data.isDiscount) { textView in
                            textView.hidden()
                        }
                }

            }.padding([.bottom, .leading, .trailing])
        }
    }
    
    var variants: some View {
        VStack(alignment: .leading) {}.padding()
    }
    
    var variantsTitle: [String] {
        return viewModel.data.variants.map { $0.name }
    }
    
    @ViewBuilder
    func topAddOns() -> some View {
        if let topAddOns = viewModel.data.addons.first {
            VStack(alignment: .leading) {
                Text(topAddOns.addonCateogryName)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                
                ForEach(0 ..< topAddOns.addonItems.count, id: \.self) { index in
                    let hideDivider = index == topAddOns.addonItems.count - 1
                    AddOnRow(item: $viewModel.topAddOns.addonItems[index], hideDivider: hideDivider)
                }
            }.padding()
        }
    }
    
    @ViewBuilder
    func addOnMenus() -> some View {
        if viewModel.data.addons.count > 1 {
            ForEach($viewModel.data.addons[1 ..< viewModel.data.addons.count]) { $addOns in
                VStack(alignment: .leading) {
                    Text(addOns.addonCateogryName)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.primary)

                    ForEach(0 ..< addOns.addonItems.count, id: \.self) { index in
                        let hideDivider = index == addOns.addonItems.count - 1

                        AddOnRow(item: $addOns.addonItems[index],
                                 hideDivider: hideDivider,
                                 isLimited: true)
                    }

                    DashLine()

                }.padding()
            }
        }
    }

    @ViewBuilder
    func notes() -> some View {
        VStack(alignment: .leading) {
            Text(L10n.notesTitle.localize)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(Color.primary)
            
            Text(L10n.notesSubTitle.localize)
                .font(.footnote)
                .foregroundColor(Color.gray.opacity(0.5))
            
            TextField(L10n.notesPlaceholder.localize, text: $notesText)
                .textFieldStyle(.plain)
                .font(.callout)
                .onChange(of: notesText.publisher.collect()) { _ in
                    limitText(maxCharactesNotes)
                    noteCharactersCount = notesText.count
                }
            
            Divider()
            
            Text("\(noteCharactersCount)/\(maxCharactesNotes)")
                .font(.footnote)
                .foregroundColor(Color.gray.opacity(0.5))
        }.padding()
    }
    
    var addToCart: some View {
        HStack {
            HStack(spacing: 16) {
                Button {
                    viewModel.reduceAddOnQty()
                } label: {
                    Image(systemName: "minus")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .foregroundColor(Color.black)
                        .frame(width: 15, height: 15, alignment: .center)
                }
                
                Text("\(viewModel.data.qty)")
                    .font(.body)
                    .foregroundColor(Color.black)
                    .fontWeight(.semibold)
                
                Button {
                    viewModel.increaseAddOnQty()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .foregroundColor(Color.black)
                        .frame(width: 15, height: 15, alignment: .center)
                }

            }.padding()
                .background(Color.white)
                .cornerRadius(6)
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                .padding(.leading)
            
            if viewModel.data.qty < 1 {
                removeItemButton()
            } else {
                addToCardButton()
            }
        }
    }
    
    @ViewBuilder
    func addToCardButton() -> some View {
        Button {} label: {
            HStack {
                Spacer()
                Text("\(L10n.addToCart.localize) \(viewModel.formattedSubtotal)")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .padding()
                    .fixedSize()
                Spacer()
            }.background(Color.blue)
                .cornerRadius(6)
                .padding([.leading, .trailing])
        }
    }
    
    @ViewBuilder
    func removeItemButton() -> some View {
        Button {} label: {
            HStack {
                Spacer()
                Text(L10n.removeItem.localize)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .padding()
                    .fixedSize()
                Spacer()
            }.background(Color.orange)
                .cornerRadius(6)
                .padding([.leading, .trailing])
        }
    }
    
    func limitText(_ upper: Int) {
        if notesText.count > upper {
            notesText = String(notesText.prefix(upper))
        }
    }
}

struct CatalogueDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        let service = MockCatalogueService()
        CatalogueDetailScreenView(viewModel: CatalogueDetailViewModel(service: service))
    }
}
