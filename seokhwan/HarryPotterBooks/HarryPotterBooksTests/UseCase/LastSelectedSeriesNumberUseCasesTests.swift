import XCTest

final class LastSelectedSeriesNumberUseCasesTests: XCTestCase {
    private var mock: AppStatesStorageProtocol!
    private var fetchUseCase: FetchableLastSelectedSeriesNumberUseCase!
    private var updateUseCase: UpdatableLastSelectedSeriesNumberUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mock = MockAppStatesStorage()
        fetchUseCase = FetchLastSelectedSeriesNumberUseCase(appStatesStorage: mock)
        updateUseCase = UpdateLastSelectedSeriesNumberUseCase(appStatesStorage: mock)
    }

    override func tearDownWithError() throws {
        updateUseCase = nil
        fetchUseCase = nil
        mock = nil
        try super.tearDownWithError()
    }

    func testExecutes() throws {
        // 지정한 적이 없으면, 기본값은 1권
        XCTAssertEqual(fetchUseCase.execute(), 1)

        // 변경 후 테스트
        updateUseCase.execute(to: 5)
        XCTAssertEqual(fetchUseCase.execute(), 5)
    }
}
