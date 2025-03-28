import Foundation

final class UpdateExpandedStateUseCase {
    private let appStatesStorage: AppStatesStorage

    init(appStatesStorage: AppStatesStorage = AppStatesStorage()) {
        self.appStatesStorage = appStatesStorage
    }

    func execute(at seriesNumber: Int, isExpanded: Bool) {
        appStatesStorage.updateIsExpanded(at: seriesNumber, value: isExpanded)
    }
}
