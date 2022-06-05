//
//  ErrorResponseModel.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import Foundation
import Alamofire

struct ErrorResponse: Error {
    let initialError: AFError
    let backendError: BackEndError?
}

struct BackEndError: Codable, Error {
    var status: String
    var message: String
}

extension ErrorResponse {
    var displayedError: String {
        return self.backendError == nil ? self.initialError.localizedDescription : self.backendError!.message
    }
}
