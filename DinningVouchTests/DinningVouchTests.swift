//
//  DinningVouchTests.swift
//  DinningVouchTests
//
//  Created by I Wayan Surya Adi Yasa on 05/06/22.
//

@testable import DinningVouch
import XCTest

class DinningVouchTests: XCTestCase {
    var mockCatalogueHomeEntity: CatalogueHomeModel!

    override func setUp() async throws {
        mockCatalogueHomeEntity = CatalogueHomeModel.mock()
    }

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
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testCatalogueHomeEntity() throws {
        print("Total catagories \(mockCatalogueHomeEntity.categories.count)")
        print("Total menus \(mockCatalogueHomeEntity.list.count)")
        XCTAssertTrue(mockCatalogueHomeEntity.list is [CatalogueHomeList])
        XCTAssertTrue(mockCatalogueHomeEntity.categories is [CatalogueHomeCategory])
    }

    func testCheckCatalogueidmapping() throws {
        let firstCatalog = mockCatalogueHomeEntity.list.first
        print("\(String(describing: firstCatalog?.id)) - \(String(describing: firstCatalog?.categoryID))")
        XCTAssertEqual(firstCatalog?.id, firstCatalog?.categoryID)
    }
}
