import Foundation

final class UpdateLastSelectedSeriesNumberUseCase {
    let appStatesStorage: AppStatesStorage

    init(appStatesStorage: AppStatesStorage = AppStatesStorage()) {
        self.appStatesStorage = appStatesStorage
    }

    func execute(to seriesNumber: Int) {
        appStatesStorage.updateLastSelectedSeriesNumber(to: seriesNumber)
    }
}
