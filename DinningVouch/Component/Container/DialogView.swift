//
//  DialogView.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import SwiftUI

struct DialogView: View {
    var title: String
    
    var subtitle: String = ""
    var buttonTitle: String?
    var didTapActionButton: (() -> Void)?
    
    public init(title: String, subtitle: String, buttonTitle: String? = nil, didTapActionButton: (() -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.buttonTitle = buttonTitle
        
        self.didTapActionButton = didTapActionButton
    }
    
    public var body: some View {
        VStack {
            Image(systemName: "menucard.fill")
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .foregroundColor(.blue)
                .frame(width: 60, height: 60, alignment: .center)
                
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            Text(subtitle)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.top, 1)
                .padding(.bottom, 15)
            
            if let buttonTitle = buttonTitle {
                Button {
                    didTapActionButton?()
                } label: {
                    HStack {
                        Spacer()
                        Text(buttonTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .padding()
                            .fixedSize()
                        Spacer()
                    }.background(Color.blue)
                        .cornerRadius(24)
                        .padding([.leading, .trailing])
                }
            }
        }.padding()
    }
}

struct DialogView_Previews: PreviewProvider {
    static var previews: some View {
        DialogView(title: "Hellp", subtitle: "World")
    }
}
