//
//  SwiftExamAppUITests.swift
//  SwiftExamAppUITests
//
//  Created by Tinku Sardar on 23/08/24.
//

import XCTest

final class SwiftExamAppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.

        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testCollectionViewLoads() throws {
        let collectionView = app.collectionViews.element
        
        // Check that the collection view exists
        XCTAssertTrue(collectionView.exists, "Collection view should exist.")
        
        // Verify that there are cells in the collection view
        let cells = collectionView.cells
        XCTAssertTrue(cells.count > 0, "Collection view should have at least one cell.")
    }
    
    func testCollectionViewCellContent() throws {
        let collectionView = app.collectionViews.element
        
        // Check that the collection view exists
        XCTAssertTrue(collectionView.exists, "Collection view should exist.")
        
        // Check if the first cell contains the expected text
        let firstCell = collectionView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "First cell should exist.")
        
        let bannerImg = firstCell.images.element
        XCTAssertTrue(bannerImg.exists, "bannerImg in the first cell should exist.")
    }
}
