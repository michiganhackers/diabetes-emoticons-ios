//
//  Diabetes_EmoticonsUITests.swift
//  Diabetes EmoticonsUITests
//
//  Created by Connor Krupp on 11/11/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import XCTest

class Diabetes_EmoticonsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        
        let tablesQuery = app.tables
        let starNotfilledButton = tablesQuery.cells.containingType(.StaticText, identifier:"CGM").buttons["star notfilled"]
        starNotfilledButton.tap()
        starNotfilledButton.tap()
        snapshot("01Starred")
        tablesQuery.staticTexts["CGM"].swipeUp()
        tablesQuery.cells.containingType(.StaticText, identifier:"Driving BG Check").childrenMatchingType(.StaticText).matchingIdentifier("Driving BG Check").elementBoundByIndex(0).swipeUp()
        tablesQuery.staticTexts["Feeling Good"].tap()
        tablesQuery.cells.containingType(.StaticText, identifier:"Field Trip BG Check").childrenMatchingType(.StaticText).matchingIdentifier("Field Trip BG Check").elementBoundByIndex(0).tap()
        tablesQuery.cells.containingType(.StaticText, identifier:"High BG").childrenMatchingType(.StaticText).matchingIdentifier("High BG").elementBoundByIndex(0).tap()
        tablesQuery.cells.containingType(.StaticText, identifier:"Insulin Pump").childrenMatchingType(.StaticText).matchingIdentifier("Insulin Pump").elementBoundByIndex(0).tap()
        snapshot("03DetailScreen")
        app.navigationBars["Insulin Pump"].childrenMatchingType(.Button).elementBoundByIndex(0).tap()
        tablesQuery.staticTexts["Insulin Pump"].swipeUp()
        snapshot("02DetailScreen")
        tablesQuery.cells.containingType(.StaticText, identifier:"Need A Break").childrenMatchingType(.StaticText).matchingIdentifier("Need A Break").elementBoundByIndex(0).pressForDuration(0.5);
        app.tabBars.buttons["Favorites"].tap()
        snapshot("04FavScreen")

        // In UI tests it’s important to set the initial state - such as interface orientat    ion - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.


    }
    
}
