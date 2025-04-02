import XCTest

final class ExpandedStateUseCasesTests: XCTestCase {
    var mockStorage: AppStatesStorageProtocol!
    var fetchExpandedStateUseCase: FetchableExpandedStateUseCase!
    var updateExpandedStateUseCase: UpdatableExpandedStateUseCase!

    override func setUpWithError() throws {
        mockStorage = MockAppStatesStorage()
        fetchExpandedStateUseCase = FetchExpandedStateUseCase(appStatesStorage: mockStorage)
        updateExpandedStateUseCase = UpdateExpandedStateUseCase(appStatesStorage: mockStorage)
    }

    override func tearDownWithError() throws {
        updateExpandedStateUseCase = nil
        fetchExpandedStateUseCase = nil
        mockStorage = nil
    }

    func testExecutes() throws {
        XCTAssertEqual(fetchExpandedStateUseCase.execute(at: 1), false)

        updateExpandedStateUseCase.execute(at: 1, isExpanded: true)
        XCTAssertEqual(fetchExpandedStateUseCase.execute(at: 1), true)
    }
}
