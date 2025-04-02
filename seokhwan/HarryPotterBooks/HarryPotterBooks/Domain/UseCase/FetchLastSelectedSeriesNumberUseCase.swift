import Foundation

protocol FetchableLastSelectedSeriesNumberUseCase {
    func execute() -> Int
}

final class FetchLastSelectedSeriesNumberUseCase: FetchableLastSelectedSeriesNumberUseCase {
    private let appStatesStorage: AppStatesStorageProtocol

    init(appStatesStorage: AppStatesStorageProtocol = AppStatesStorage()) {
        self.appStatesStorage = appStatesStorage
    }

    func execute() -> Int {
        return appStatesStorage.lastSelectedSeriesNumber()
    }
}
