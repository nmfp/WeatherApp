//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Nuno Pereira on 20/05/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppUITests: XCTestCase {
    
    var app: XCUIApplication!
    var weatherTable: XCUIElement!
    var titleLabel: XCUIElement!
    var searchBar: XCUIElement!
    var clearTextButton: XCUIElement!
    var cancelSearchButton: XCUIElement!
    
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        weatherTable = app.tables.element(boundBy: 0)
        searchBar = app.searchFields["Search"]
        clearTextButton = app.buttons["Clear text"]
        cancelSearchButton = app.buttons["Cancel"]
        titleLabel = weatherTable.otherElements["Search for the weather in your city:"]
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func waitForElement(predicateString: String, element: Any)  -> Bool {
        let predicate = NSPredicate(format: predicateString)
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: 5)
        return result == .completed
    }
    
    
    func testInitialStateEmptyTable(){
        searchBar.tap()
        searchBar.typeText("")
        XCTAssert(weatherTable.cells.count == 0)
        XCTAssert(titleLabel.identifier == "Search for the weather in your city:")
    }
    
    func testCancelSearch() {
        searchBar.tap()
        searchBar.typeText("Lisbon")
        
        let expectedNumberCities = 10
        let predicateString = "count == \(expectedNumberCities)"
        XCTAssert(waitForElement(predicateString: predicateString, element: weatherTable.cells))
        
        cancelSearchButton.tap()
        XCTAssert(weatherTable.cells.count == 0)
    }
    
    func testCaseNoCitiesExistsForName() {
        searchBar.tap()
        XCTAssert(titleLabel.exists)
        searchBar.typeText("Abudhab")
        
        let noCitiesFoundLabel = app.tables.staticTexts["No cities found."]
        let predicateString = "exists == true"
        XCTAssert(waitForElement(predicateString: predicateString, element: noCitiesFoundLabel))
    }
    
    func testClearSearchedTextForNewSearch() {
        
        searchBar.tap()
        XCTAssert(titleLabel.exists)
        searchBar.typeText("Abu dhabi")
    
        let expectedNumberCities = 1
        let predicateString = "count == \(expectedNumberCities)"
        XCTAssert(waitForElement(predicateString: predicateString, element: weatherTable.cells))
        
        searchBar.tap()
        clearTextButton.tap()
        XCTAssert(weatherTable.cells.count == 0)
    }
}

