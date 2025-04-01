import XCTest

final class LastSelectedSeriesNumberUseCasesTests: XCTestCase {
    private var mockStorage: AppStatesStorageProtocol!
    private var fetchLastSelectedSeriesNumberUseCase: FetchableLastSelectedSeriesNumberUseCase!
    private var updateLastSelectedSeriesNumberUseCase: UpdatableLastSelectedSeriesNumberUseCase!

    override func setUpWithError() throws {
        mockStorage = MockAppStatesStorage()
        fetchLastSelectedSeriesNumberUseCase = FetchLastSelectedSeriesNumberUseCase(appStatesStorage: mockStorage)
        updateLastSelectedSeriesNumberUseCase = UpdateLastSelectedSeriesNumberUseCase(appStatesStorage: mockStorage)
    }

    override func tearDownWithError() throws {
        updateLastSelectedSeriesNumberUseCase = nil
        fetchLastSelectedSeriesNumberUseCase = nil
        mockStorage = nil
    }

    func testExecutes() throws {
        XCTAssertEqual(fetchLastSelectedSeriesNumberUseCase.execute(), 1)

        updateLastSelectedSeriesNumberUseCase.execute(to: 5)
        XCTAssertEqual(fetchLastSelectedSeriesNumberUseCase.execute(), 5)
    }
}
