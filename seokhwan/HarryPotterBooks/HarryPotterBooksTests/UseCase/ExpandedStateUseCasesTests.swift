import XCTest

final class ExpandedStateUseCasesTests: XCTestCase {
    private var mock: AppStatesStorageProtocol!
    private var fetchUseCase: FetchableExpandedStateUseCase!
    private var updateUseCase: UpdatableExpandedStateUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mock = MockAppStatesStorage()
        fetchUseCase = FetchExpandedStateUseCase(appStatesStorage: mock)
        updateUseCase = UpdateExpandedStateUseCase(appStatesStorage: mock)
    }

    override func tearDownWithError() throws {
        updateUseCase = nil
        fetchUseCase = nil
        mock = nil
        try super.tearDownWithError()
    }

    func testExecutes() throws {
        // 지정한 적이 없으면, 기본값은 false
        XCTAssertEqual(fetchUseCase.execute(at: 1), false)

        // 확장시킨 후 테스트
        updateUseCase.execute(at: 1, isExpanded: true)
        XCTAssertEqual(fetchUseCase.execute(at: 1), true)
    }
}
