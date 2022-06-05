//
//  ContentView.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding().onAppear {
                print("Info plit : \(AppConfiguration.baseURL)")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
