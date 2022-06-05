//
//  AddOnRow.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import SwiftUI

struct AddOnRow: View {
    @Binding var item: AddOnItemViewData
    var hideDivider: Bool = false
    var isLimited: Bool = false
    var body: some View {
        VStack {
            HStack {
                Text(item.name)
                    .font(.footnote)
                Spacer()
                
                HStack(spacing: 12) {
                    Button {
                        item.reduceQty()
                    } label: {
                        Image(systemName: "minus")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .foregroundColor(Color.primary)
                            .frame(width: 10, height: 10, alignment: .center)
                    }
                    
                    Text("\(item.displayedQty)")
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Button {
                        item.addQty()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .foregroundColor(Color.primary)
                            .frame(width: 10, height: 10, alignment: .center)
                    }

                }.padding(.horizontal, 8)
                    .if(isLimited || !item.enabled) { view in
                        view.hidden()
                    }
                
                Text("SGD \(item.additionalPrice)")
                    .font(.footnote)
                    .fontWeight(.bold)
                
                Checkbox(toggle: $item.enabled)
            }
            Divider()
                .if(hideDivider) { divider in
                    divider.hidden()
                }
        }.padding(4)
    }
}

struct AddOnRow_Previews: PreviewProvider {
    static var previews: some View {
        let mockData = CatalogueDetailViewData.mock()
        let viewData = mockData.addons[0].addonItems[0]
        AddOnRow(item: .constant(viewData))
    }
}
