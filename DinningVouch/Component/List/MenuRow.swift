//
//  MenuRow.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import NukeUI
import SwiftUI

struct MenuRow: View {
    let item: CatalogueHomeItem

    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading,
                   spacing: 10) {
                Text(item.name)
                    .foregroundColor(Color.black)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                Text(item.itemDescription)
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
                        .foregroundColor(Color.black)
                        .font(.footnote)
                        .fontWeight(.bold)

                    Text("SGD \(item.formattedPrice)")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .strikethrough()
                        .if(!item.isDiscount) { textView in
                            textView.hidden()
                        }
                }

            }.padding()

            LazyImage(source: item.imageURL) { state in
                if let image = state.image {
                    image
                        .scaledToFill()
                        .frame(width: 150, height: 170)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 150, height: 170)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
        //.shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        let mockData = CatalogueHomeModel.mock()
        MenuRow(item: (mockData.list.first?.items.first)!)
    }
}

