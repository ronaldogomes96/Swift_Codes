//
//  Project39UITests.swift
//  Project39UITests
//
//  Created by Ronaldo Gomes on 06/06/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import XCTest

class Project39UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialStateIsCorrect() {
        
        //Executa varias interacoes como se fosse o usuario
        let table = XCUIApplication().tables
        XCTAssertEqual(table.cells.count, 7, "There should be 7 rows initially")
    }
    func testUserFilteringByString() {
        
        //Executa o passo a passo de uma interacao do usuario
       let app = XCUIApplication()
       app.buttons["Search"].tap()

       let filterAlert = app.alerts
       let textField = filterAlert.textFields.element
       textField.typeText("test")

       filterAlert.buttons["Filter"].tap()

       XCTAssertEqual(app.tables.cells.count, 56, "There should be 56 words matching 'test'")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
