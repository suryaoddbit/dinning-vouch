//
//  CatalogueDetailModel.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import Foundation

// MARK: - CatalogueDetailModel

struct CatalogueDetailModel: Codable {
    let id: String
    let price, displayPrice: Double
    let isDiscount: Bool
    let discountPercent: Int
    let imageURL: String
    let name, catalogueDetailModelDescription: String
    let tags: [String]
    let variants: [Variant]
    var addons: [Addon]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case price
        case displayPrice = "display_price"
        case isDiscount = "is_discount"
        case discountPercent = "discount_percent"
        case imageURL = "image_url"
        case name
        case catalogueDetailModelDescription = "description"
        case tags, variants, addons
    }
}

// MARK: - Addon

struct Addon: Codable {
    var id: String {
        return addonCategoryID
    }

    var addonCategoryID, addonCateogryName: String
    var addonItems: [AddonItem]

    enum CodingKeys: String, CodingKey {
        case addonCategoryID = "addon_category_id"
        case addonCateogryName = "addon_cateogry_name"
        case addonItems = "addon_items"
    }
}

// MARK: - AddonItem

struct AddonItem: Codable {
    let id, name: String
    let additionalPrice: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case additionalPrice = "additional_price"
    }
}

// MARK: - Variant

struct Variant: Codable {
    let id, name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}
