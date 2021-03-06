//
//  DinningVouchUiInspectorTest.swift
//  DinningVouchTests
//
//  Created by I Wayan Surya Adi Yasa on 06/06/22.
//

import XCTest
@testable import DinningVouch
import SwiftUI
import ViewInspector

extension CatalogueHomeScreenView: Inspectable {}
class DinningVouchUiInspectorTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMenuTapHomeScreen() throws {
        // expectation: menu view should have same total and id as the category
        
        let mockService = MockCatalogueService()
        let vm = CatalogueHomeViewModel(service: mockService)
        let homeScreen = CatalogueHomeScreenView(viewModel: vm)

        
        if let categories = vm.data?.categories {
            for category in categories {
                let categoryId = try? homeScreen.inspect().find(viewWithId: category.hashValue)
                XCTAssertFalse(categoryId == nil)
            }

        }
    }

}
