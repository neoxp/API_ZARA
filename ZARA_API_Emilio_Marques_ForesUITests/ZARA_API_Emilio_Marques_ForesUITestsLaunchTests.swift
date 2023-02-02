//
//  ZARA_API_Emilio_Marques_ForesUITestsLaunchTests.swift
//  ZARA_API_Emilio_Marques_ForesUITests
//
//  Created by Emilio_Marques_Fores on 2/2/23.
//

import XCTest

final class ZARA_API_Emilio_Marques_ForesUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
