import Foundation

protocol FetchableExpandedStateUseCase {
    func execute(at seriesNumber: Int) -> Bool
}

final class FetchExpandedStateUseCase: FetchableExpandedStateUseCase {
    private let appStatesStorage: AppStatesStorageProtocol

    init(appStatesStorage: AppStatesStorageProtocol = AppStatesStorage()) {
        self.appStatesStorage = appStatesStorage
    }

    func execute(at seriesNumber: Int) -> Bool {
        return appStatesStorage.isExpanded(at: seriesNumber)
    }
}
