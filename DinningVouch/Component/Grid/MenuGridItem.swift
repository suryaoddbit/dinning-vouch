//
//  MenuGridItem.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import NukeUI
import SwiftUI

struct MenuGridItem: View {
    let item: CatalogueHomeItem

    var body: some View {
        VStack(spacing: 8) {
            LazyImage(source: item.imageURL) { state in
                if let image = state.image {
                    image
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 170)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 170)
                }
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(item.name + "\n")
                    .font(.callout)
                    .foregroundColor(Color.black)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                Text(item.itemDescription + "\n")
                    .font(.caption2)
                    .foregroundColor(Color.gray)
                    .lineLimit(2)

                FlexibleView(data: item.displayedTags[...1], spacing: 8, alignment: .leading) { value in
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
                    Text("SGD \(item.formattedDisplayPrice)")
                        .font(.footnote)
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)

                    Text("SGD \(item.formattedPrice)")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .strikethrough()
                        .if(!item.isDiscount) { textView in
                            textView.hidden()
                        }
                }

            }.padding([.bottom, .leading, .trailing])
        }
        .frame(width: 250)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
        
        
    }
}

struct MenuGridItem_Previews: PreviewProvider {
    static var previews: some View {
        let mockData = CatalogueHomeModel.mock()
        MenuGridItem(item: (mockData.list.first?.items.first)!)
    }
}
