//
//  MenuOptionsView.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import SwiftUI

struct MenuOptionsView: View {
    var title: String?
    var placeholder: String?
    let options: [String]
    @State var titleValue: String = ""
    var onMenuSelected: ((_ index: Int) -> Void)?
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            if let title = self.title {
                Text(title)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
            }
            Menu {
                ForEach(0 ..< options.count, id: \.self) { index in
                    HStack {
                        Button {
                            titleValue = options[index].capitalized
                            onMenuSelected?(index)
                        } label: {
                            Text(options[index].capitalized)
                        }
                    }
                }
            } label: {
                HStack {
                    Text(titleValue.isEmpty ? self.placeholder?.capitalized ?? "" : titleValue.capitalized)
                        .font(.footnote)
                        .opacity(titleValue.isEmpty ? 0.3 : 1)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 8, alignment: .center)
                        .padding(.trailing, 8)
                        .if(!titleValue.isEmpty) { image in
                            image.hidden()
                        }
                }.padding(16)
                    .cornerRadius(10)
                    .font(.callout)
                    .foregroundColor(Color.primary)
                    .accentColor(Color.primary)
                    .disabled(true)
                    .if(titleValue.isEmpty) { view in
                        view.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.2), lineWidth: 2))
                    }.if(!titleValue.isEmpty) { view in
                        view.overlay(Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray.opacity(0.3)), alignment: .bottom)
                    }
            }
                                   
        }.foregroundColor(.white)
    }
}

struct MenuOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        MenuOptionsView( options: [])
    }
}
