import Foundation

final class FetchLastSelectedSeriesNumberUseCase {
    private let appStatesStorage: AppStatesStorage

    init(appStatesStorage: AppStatesStorage = AppStatesStorage()) {
        self.appStatesStorage = appStatesStorage
    }

    func execute() -> Int {
        return appStatesStorage.lastSelectedSeriesNumber()
    }
}
