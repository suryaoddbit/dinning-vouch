//
//  CatalogueDetailViewData.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import Foundation

struct CatalogueDetailViewData: Equatable {
    static func == (lhs: CatalogueDetailViewData, rhs: CatalogueDetailViewData) -> Bool {
        return lhs.id == rhs.id && lhs.qty == rhs.qty
            && lhs.addons == rhs.addons
    }
    
    var id: String
    var price, displayPrice: Double
    var isDiscount: Bool
    var discountPercent: Int
    var imageURL: String
    var name, catalogueDetailModelDescription: String
    var tags: [String]
    var variants: [Variant]
    var addons: [AddOnViewData]
    
    init(entity: CatalogueDetailModel) {
        self.id = entity.id
        self.price = entity.price
        self.displayPrice = entity.displayPrice
        self.isDiscount = entity.isDiscount
        self.discountPercent = entity.discountPercent
        self.imageURL = entity.imageURL
        self.name = entity.name
        self.catalogueDetailModelDescription = entity.catalogueDetailModelDescription
        self.tags = entity.tags
        self.variants = entity.variants
        self.addons = entity.addons.map { AddOnViewData(entity: $0) }
    }
    
    init() {
        self.id = ""
        self.price = 0
        self.displayPrice = 0
        self.isDiscount = false
        self.discountPercent = 0
        self.imageURL = ""
        self.name = ""
        self.catalogueDetailModelDescription = ""
        self.tags = []
        self.variants = []
        self.addons = []
    }
    
    var qty: Int = 1
    var enabled: Bool = false
    
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
    
    

    static func mock() -> CatalogueDetailViewData {
        do {
            guard let filePath = Bundle.main.path(forResource: "MockCatalogueDetail", ofType: "json") else {
                fatalError("Failed to retrieve response")
            }

            let decoder = JSONDecoder()
            let data = try! Data(contentsOf: URL(fileURLWithPath: filePath),
                                 options: .mappedIfSafe)
            let entity = try decoder.decode(CatalogueDetailModel.self, from: data)
            return CatalogueDetailViewData(entity: entity)
        } catch {
            return CatalogueDetailViewData()
        }
    }
}

struct AddOnViewData: Identifiable, Equatable {
    static func == (lhs: AddOnViewData, rhs: AddOnViewData) -> Bool {
        return lhs.addonCategoryID == rhs.addonCategoryID && lhs.addonItems == rhs.addonItems
    }
    
    var id: String {
        return addonCategoryID
    }

    var addonCategoryID, addonCateogryName: String
    var addonItems: [AddOnItemViewData]
    
    init(entity: Addon) {
        self.addonCategoryID = entity.addonCategoryID
        self.addonCateogryName = entity.addonCateogryName
        self.addonItems = entity.addonItems.map { AddOnItemViewData(entity: $0) }
    }
}

struct AddOnItemViewData: Identifiable, Equatable {
    static func == (lhs: AddOnItemViewData, rhs: AddOnItemViewData) -> Bool {
        return lhs.id == rhs.id && lhs.qty == rhs.qty && lhs.enabled == rhs.enabled
    }
    
    let id, name: String
    let additionalPrice: Int
    
    init(entity: AddonItem) {
        self.id = entity.id
        self.name = entity.name
        self.additionalPrice = entity.additionalPrice
    }
    
    private var qty: Int = 1
    
    var displayedQty: Int {
        return qty
    }
    var enabled: Bool = false
    
    mutating func addQty(){
        qty += 1
    }
    
    mutating func reduceQty(){
        qty = max(0, qty - 1)
    }
}
