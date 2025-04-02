import Foundation

protocol UpdatableLastSelectedSeriesNumberUseCase {
    func execute(to seriesNumber: Int)
}

final class UpdateLastSelectedSeriesNumberUseCase: UpdatableLastSelectedSeriesNumberUseCase {
    private let appStatesStorage: AppStatesStorageProtocol

    init(appStatesStorage: AppStatesStorageProtocol = AppStatesStorage()) {
        self.appStatesStorage = appStatesStorage
    }

    func execute(to seriesNumber: Int) {
        appStatesStorage.updateLastSelectedSeriesNumber(to: seriesNumber)
    }
}
