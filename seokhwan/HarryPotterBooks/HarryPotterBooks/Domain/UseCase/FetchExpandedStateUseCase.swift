import Foundation

final class FetchExpandedStateUseCase {
    private let appStatesStorage: AppStatesStorage

    init(appStatesStorage: AppStatesStorage = AppStatesStorage()) {
        self.appStatesStorage = appStatesStorage
    }

    func execute(at seriesNumber: Int) -> Bool {
        return appStatesStorage.isExpanded(at: seriesNumber)
    }
}
