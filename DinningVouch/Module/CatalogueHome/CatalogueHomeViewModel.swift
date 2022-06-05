//
//  CatalogueHomeViewModel.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import Foundation
import Combine

class CatalogueHomeViewModel: ListLoadableObject {
    @Published var state: ListLoadingState<CatalogueHomeModel> = .idle
    
    @Published var data: CatalogueHomeModel?
    let service: ICatalogueService
    var subscription = Set<AnyCancellable>()
    @Published var selectedCategoy: String?
    
    init(service: ICatalogueService) {
        self.service = service
        fetchCatalogueHome()
    }
    
    func load() {
        state = .loading
        
    }
    
    func fetchCatalogueHome() {
        service.fetchCatalogueHome().sink { [self] response in
            if let errorResponse = response.error {
                print("ERROR : \(errorResponse.displayedError)")
                state = .failed
                return
            }
            
            guard let data = response.value else {
                print("No Data Found")
                state = .empty
                return
            }
            
            self.data = data
            self.selectedCategoy = data.categories.first?.id
            state = .loaded(data)
        }.store(in: &subscription)
    }
}
