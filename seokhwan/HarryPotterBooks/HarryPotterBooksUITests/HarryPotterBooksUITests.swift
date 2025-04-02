import XCTest

final class HarryPotterBooksUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launchEnvironment["UITest_UserDefaults_Suite"] = "uiTestSuite"
        app.launchArguments.append("--reset-uiTestSuite")
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
        try super.tearDownWithError()
    }

    @MainActor func testSelectedSeriesNumber() throws {
        let nextSeriesNumberButton = app.buttons["seriesNumberButton2"]
        XCTAssertEqual(nextSeriesNumberButton.exists, true)

        nextSeriesNumberButton.tap()

        let bookTitleLabel = app.staticTexts["bookTitleLabel"]
        XCTAssertEqual(bookTitleLabel.label, "Harry Potter and the Chamber of Secrets")
    }

    @MainActor func testToggleMoreButton() throws {
        let seriesNumberButton = app.buttons["seriesNumberButton1"]
        XCTAssertEqual(seriesNumberButton.exists, true)

        seriesNumberButton.tap()

        let moreButton = app.buttons["moreButton"]
        XCTAssertEqual(moreButton.exists, true)

        let summaryContentLabel = app.staticTexts["contentLabelOfSummary"]
        XCTAssertEqual(summaryContentLabel.exists, true)

        XCTAssertEqual(moreButton.label, "더 보기")
        XCTAssertEqual(summaryContentLabel.label.suffix(3), "...")

        moreButton.tap()

        XCTAssertEqual(moreButton.label, "접기")
        XCTAssertNotEqual(summaryContentLabel.label.suffix(3), "...")
    }

    @MainActor func testMoreButtonIsHiddenWhenLessThan450Characters() throws {
        let nextSeriesNumberButton = app.buttons["seriesNumberButton2"]
        XCTAssertEqual(nextSeriesNumberButton.exists, true)

        nextSeriesNumberButton.tap()

        let moreButton = app.buttons["moreButton"]
        XCTAssertEqual(moreButton.exists, false)
    }
}
