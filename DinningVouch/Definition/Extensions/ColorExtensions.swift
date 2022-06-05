//
//  ColorExtensions.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import Foundation
import SwiftUI

public extension Color {
    static let tabBarbackground = Color("tabBarbackground")
    
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}
public extension UIColor {
    var alphaValue: CGFloat { return CIColor(color: self).alpha }
}
