//
//  AppConfiguration.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import Foundation

enum AppConfiguration {
    enum Keys {
        static let baseURL = "BASE_URL"
        static let baseURLPath = "BASE_URL_PATH"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let plist = Bundle.main.infoDictionary else {
            fatalError("Could not retrieve plist")
        }
        
        return plist
    }()
    
    static let baseURL: String = {
        guard let baseURLString = AppConfiguration.infoDictionary[Keys.baseURL] as? String else {
            fatalError("Could not retrieve BASE_URL from plist")
        }
        
        return baseURLString
    }()
    
    static let baseURLPath: String = {
        guard let baseURLPathString = AppConfiguration.infoDictionary[Keys.baseURLPath] as? String else {
            fatalError("Could not retrieve BASE_URL_PATH from plist")
        }
        
        return baseURLPathString
    }()
}
