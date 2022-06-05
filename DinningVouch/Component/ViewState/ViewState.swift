//
//  ViewState.swift
//  DinningVouch
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

import Foundation

enum ListLoadingState<Value> {
    case idle
    case loading
    case failed
    case loaded(Value)
    case empty
}

protocol ListLoadableObject: ObservableObject {
    associatedtype Output
    var state: ListLoadingState<Output> { get }
    func load()
}
