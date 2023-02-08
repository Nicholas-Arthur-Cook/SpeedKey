//
//  SettingsMenuUITests.swift
//  SettingsMenuUITests
//
//  Created by Chloe Snyders on 2/6/23.
//

import XCTest


final class SettingsMenuUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_containsAllToggles() throws {
        let app = XCUIApplication()
        app.launch()
        
        let toggles = ["autoDeleteToggle", "typoNotificationToggle", "reviewPreviousWordsToggle"]
        toggles.forEach { toggle in
            // Test that toggle is enabled for user interaction
            XCTAssertTrue(app.switches[toggle].isEnabled)
            // Test that toggle is disabled before user interaction
            XCTAssertTrue(app.switches[toggle].value as? String == "0")
        }
    }
    
    // Note: Could not test for Pickers existance. Most UI will have to be tested via visual inspection
}
