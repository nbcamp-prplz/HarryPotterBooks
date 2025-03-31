import Foundation

struct MockFetchExpandedStateUseCase: FetchableExpandedStateUseCase {
    var result: Bool

    func execute(at seriesNumber: Int) -> Bool {
        return result
    }
}
