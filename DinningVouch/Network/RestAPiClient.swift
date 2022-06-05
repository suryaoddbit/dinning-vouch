//
//  RestAPiClient.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import Foundation
import Alamofire

class RestAPiClient {
    func execute(path: String, method: HTTPMethod, parameters: [String: Any]? = nil) -> DataRequest {
        guard let baseUrl = URL(string: AppConfiguration.baseURL) else {
            fatalError("Could not retrieve Base URL")
        }
        let url = baseUrl.appendingPathComponent(path)

        return AF.request(url, method: method, parameters: parameters)
    }
}
