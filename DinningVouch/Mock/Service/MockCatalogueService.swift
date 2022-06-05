//
//  MockCatalogueService.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import Foundation
import Combine
import Alamofire

class MockCatalogueService: ICatalogueService {
    private let decoder = JSONDecoder()
    
    func fetchCatalogueHome() -> AnyPublisher<DataResponse<CatalogueHomeModel, ErrorResponse>, Never> {
        do {
            guard let filePath = Bundle.main.path(forResource: "MockCatalogHomeData", ofType: "json") else {
                fatalError("Failed to retrieve response")
            }
            
            let data = try! Data(contentsOf: URL(fileURLWithPath: filePath),
                                 options: .mappedIfSafe)
            
            let entity = try decoder.decode(CatalogueHomeModel.self, from: data)
            let result = Result<CatalogueHomeModel, ErrorResponse>.success(entity)
            let dataresponse = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
            return Just(dataresponse).eraseToAnyPublisher()
        } catch {
            let error = ErrorResponse(initialError: AFError.sessionDeinitialized, backendError: nil)
            let result = Result<CatalogueHomeModel, ErrorResponse>.failure(error)
            let dataresponse = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
            return Just(dataresponse).eraseToAnyPublisher()
        }
    }
    
    func fetchMenuDetails() -> AnyPublisher<DataResponse<CatalogueDetailModel, ErrorResponse>, Never> {
        do {
            guard let filePath = Bundle.main.path(forResource: "MockCatalogueDetail", ofType: "json") else {
                fatalError("Failed to retrieve response")
            }
            
            let data = try! Data(contentsOf: URL(fileURLWithPath: filePath),
                                 options: .mappedIfSafe)
            
            let entity = try decoder.decode(CatalogueDetailModel.self, from: data)
            let result = Result<CatalogueDetailModel, ErrorResponse>.success(entity)
            let dataresponse = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
            return Just(dataresponse).eraseToAnyPublisher()
        } catch {
            let error = ErrorResponse(initialError: AFError.sessionDeinitialized, backendError: nil)
            let result = Result<CatalogueDetailModel, ErrorResponse>.failure(error)
            let dataresponse = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
            return Just(dataresponse).eraseToAnyPublisher()
        }
    }
}
