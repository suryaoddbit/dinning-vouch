//
//  L10n.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 06/06/22.
//

import Foundation

enum L10n: String {
    
    case menuOptionTitle
    case menuOptionPlaceholder
    
    case homeScreenNavigationTitle
    
    case failStateTitle
    case failStateSubTitle
    case failStateButton
    
    case emptyStateTitle
    case emptyStateSubTitle
    
    case notesTitle
    case notesSubTitle
    case notesPlaceholder
    
    case addToCart
    case removeItem
    
    public var localize: String {
        return NSLocalizedString(self.rawValue, comment: "l10n default")
    }
}
