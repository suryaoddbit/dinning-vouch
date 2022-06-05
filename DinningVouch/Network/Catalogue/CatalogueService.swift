//
//  CatalogueService.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import Foundation
import Combine
import Alamofire

protocol ICatalogueService {
    func fetchCatalogueHome() -> AnyPublisher<DataResponse<CatalogueHomeModel, ErrorResponse>, Never>
    func fetchMenuDetails() -> AnyPublisher<DataResponse<CatalogueDetailModel, ErrorResponse>, Never>
}

class CatalogueService: RestAPiClient, ICatalogueService {
    func fetchCatalogueHome() -> AnyPublisher<DataResponse<CatalogueHomeModel, ErrorResponse>, Never> {
        return execute(path: "/ios/catalogue/home", method: .get)
            .validate()
            .publishDecodable(type: CatalogueHomeModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackEndError.self, from: $0) }
                    return ErrorResponse(initialError: error, backendError: backendError)
                }
            }.receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func fetchMenuDetails() -> AnyPublisher<DataResponse<CatalogueDetailModel, ErrorResponse>, Never> {
        return execute(path: "/ios/catalogue/detail", method: .get)
            .validate()
            .publishDecodable(type: CatalogueDetailModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackEndError.self, from: $0) }
                    return ErrorResponse(initialError: error, backendError: backendError)
                }
            }.receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
