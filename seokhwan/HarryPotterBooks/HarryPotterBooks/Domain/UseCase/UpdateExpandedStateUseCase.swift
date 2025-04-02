import Foundation

protocol UpdatableExpandedStateUseCase {
    func execute(at seriesNumber: Int, isExpanded: Bool)
}

final class UpdateExpandedStateUseCase: UpdatableExpandedStateUseCase {
    private let appStatesStorage: AppStatesStorageProtocol

    init(appStatesStorage: AppStatesStorageProtocol = AppStatesStorage()) {
        self.appStatesStorage = appStatesStorage
    }

    func execute(at seriesNumber: Int, isExpanded: Bool) {
        appStatesStorage.updateIsExpanded(at: seriesNumber, value: isExpanded)
    }
}
