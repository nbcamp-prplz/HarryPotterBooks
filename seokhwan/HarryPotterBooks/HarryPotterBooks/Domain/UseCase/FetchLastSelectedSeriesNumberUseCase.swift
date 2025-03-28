import Foundation

final class FetchLastSelectedSeriesNumberUseCase {
    let appStatesStorage: AppStatesStorage

    init(appStatesStorage: AppStatesStorage = AppStatesStorage()) {
        self.appStatesStorage = appStatesStorage
    }

    func execute() -> Int {
        return appStatesStorage.lastSelectedSeriesNumber()
    }
}
