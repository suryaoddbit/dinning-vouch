//
//  CatalogueHomeModel.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import Foundation

// MARK: - CatalogueHomeModel
struct CatalogueHomeModel: Codable {
    let categories: [CatalogueHomeCategory]
    let list: [CatalogueHomeList]

    static func mock() -> CatalogueHomeModel {
        do {
            guard let filePath = Bundle.main.path(forResource: "MockCatalogHomeData", ofType: "json") else {
                fatalError("Failed to retrieve response")
            }

            let decoder = JSONDecoder()
            let data = try! Data(contentsOf: URL(fileURLWithPath: filePath),
                                 options: .mappedIfSafe)
            let entity = try decoder.decode(CatalogueHomeModel.self, from: data)
            return entity
        } catch {
            return CatalogueHomeModel(categories: [], list: [])
        }
    }
}


struct CatalogueHomeCategory: Codable, Identifiable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let id, name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
    
    
}


struct CatalogueHomeList: Codable, Identifiable, Hashable {
    static func == (lhs: CatalogueHomeList, rhs: CatalogueHomeList) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(categoryID)
    }
    
    var id: String {
        return categoryID
    }
    
    let categoryID: String
    let items: [CatalogueHomeItem]

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case items
    }
    
    var displayName: String {
        return categoryID.replacingOccurrences(of: "_", with: " ")
    }
}


struct CatalogueHomeItem: Codable, Identifiable {
    let id: String
    let price, displayPrice: Double
    let isDiscount: Bool
    let discountPercent: Int
    let imageURL: String
    let name, itemDescription: String
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case price
        case displayPrice = "display_price"
        case isDiscount = "is_discount"
        case discountPercent = "discount_percent"
        case imageURL = "image_url"
        case name
        case itemDescription = "description"
        case tags
    }

    var displayedTags: [String] {
        return tags.map { tag in
            tag.replacingOccurrences(of: "_", with: "-")
        }
    }
    
    var formattedDisplayPrice: String {
        return String(format: "%.2f", displayPrice)
    }
    
    var formattedPrice: String {
        return String(format: "%.2f", price)
    }
}
