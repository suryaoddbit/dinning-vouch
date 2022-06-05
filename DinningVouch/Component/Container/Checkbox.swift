//
//  Checkbox.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import SwiftUI

struct Checkbox: View {
    @Binding var toggle: Bool
    var body: some View {
        Button(action: {
            self.toggle.toggle()
        }) {
            Image(systemName: self.toggle ? "checkmark.square" : "square")
                .renderingMode(.template)
                .resizable()
                .padding(0)
                .frame(width: 14.0, height: 14.0)
                .foregroundColor(Color.gray)
        }
        .buttonStyle(PlainButtonStyle())
        .cornerRadius(0)
    }
}

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        Checkbox(toggle: .constant(true))
    }
}
