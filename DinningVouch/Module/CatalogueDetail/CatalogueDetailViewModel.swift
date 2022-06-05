//
//  CatalogueDetailViewModel.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import Foundation
import Combine

class CatalogueDetailViewModel: ListLoadableObject {
    @Published var state: ListLoadingState<CatalogueDetailViewData> = .idle
    @Published var data: CatalogueDetailViewData = .init()
    
    let service: ICatalogueService
    var subscription = Set<AnyCancellable>()
    
    @Published var subTotal: Double = 0
    
    init(service: ICatalogueService) {
        self.service = service
        load()
    }
    
    func load() {
        state = .loading
        fetchMenuDetails()
    }
    
    func fetchMenuDetails() {
        service.fetchMenuDetails().sink { [self] response in
            if let errorResponse = response.error {
                print("ERROR : \(errorResponse.displayedError)")
                state = .failed
                return
            }
            
            guard let data = response.value else {
                state = .empty
                print("No Data Found")
                return
            }
            
            self.data = CatalogueDetailViewData(entity: data)
            state = .loaded(self.data)
        }.store(in: &subscription)
    }
    
    func increaseAddOnQty() {
        data.qty += 1
    }
    
    func reduceAddOnQty() {
        data.qty = max(0, data.qty - 1)
    }
    
    var topAddOns: AddOnViewData {
        get {
            return data.addons[0]
        }
        set(value) {
            data.addons[0] = value
        }
    }
    
    func calculateTotal() {
        let addOnItems = data.addons.map{ $0.addonItems}.flatMap{ $0 }
        let sumOfAddOnCost = addOnItems.map { data in
            if data.enabled {
                return data.additionalPrice * data.displayedQty
            } else {
                return 0
            }
        }.reduce(0, +)
        
        subTotal = Double(data.qty * sumOfAddOnCost)
    }
    
    var formattedSubtotal: String {
        if subTotal <= 0 {
            return ""
        }
        return String(format: "- SGD %.2f", subTotal)
    }
}

