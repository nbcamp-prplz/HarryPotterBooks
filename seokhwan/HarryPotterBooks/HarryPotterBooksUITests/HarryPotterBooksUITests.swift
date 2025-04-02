import XCTest

final class HarryPotterBooksUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launchEnvironment["UITest_UserDefaults_Suite"] = "uiTestSuite" // UITest 전용 Suite 사용
        app.launchArguments.append("--reset-uiTestSuite") // UserDefaults의 "uiTestSuite" 영역만 초기화
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
        try super.tearDownWithError()
    }

    @MainActor func testSelectedSeriesNumber() throws {
        let nextSeriesNumberButton = app.buttons["seriesNumberButton2"] // 2권 버튼
        XCTAssertEqual(nextSeriesNumberButton.exists, true)

        nextSeriesNumberButton.tap()

        let bookTitleLabel = app.staticTexts["bookTitleLabel"]
        XCTAssertEqual(bookTitleLabel.label, "Harry Potter and the Chamber of Secrets")
    }

    @MainActor func testToggleMoreButton() throws {
        let seriesNumberButton = app.buttons["seriesNumberButton1"] // 1권 버튼
        XCTAssertEqual(seriesNumberButton.exists, true)

        seriesNumberButton.tap()

        let moreButton = app.buttons["moreButton"]
        XCTAssertEqual(moreButton.exists, true)

        let summaryContentLabel = app.staticTexts["contentLabelOfSummary"]
        XCTAssertEqual(summaryContentLabel.exists, true)

        XCTAssertEqual(moreButton.label, "더 보기")
        XCTAssertEqual(summaryContentLabel.label.suffix(3), "...") // 확장 상태일 경우, suffix가 ...인지 확인

        moreButton.tap()

        XCTAssertEqual(moreButton.label, "접기")
        XCTAssertNotEqual(summaryContentLabel.label.suffix(3), "...") // 확장 상태가 아닐 경우, suffix가 ...이 아닌지 확인
    }

    @MainActor func testMoreButtonIsHiddenWhenLessThan450Characters() throws {
        let nextSeriesNumberButton = app.buttons["seriesNumberButton2"] // 2권 버튼
        XCTAssertEqual(nextSeriesNumberButton.exists, true)

        nextSeriesNumberButton.tap()

        let moreButton = app.buttons["moreButton"]
        XCTAssertEqual(moreButton.exists, false) // 2권은 450자 미만이기 때문에, moreButton이 존재하면 안됨
    }
}
