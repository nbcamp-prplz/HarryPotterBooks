import UIKit
import Combine

final class HPBSeriesNumberButtonsView: UIStackView {
    let seriesNumberButtonOnTapPublisher = PassthroughSubject<Int, Never>()

    private var cancellables = Set<AnyCancellable>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func generateSeriesNumberButtons(numberOf count: Int) {
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }

        let publishers = (1...count).map {
            let button = HPBSeriesNumberButton(seriesNumber: $0)
            addArrangedSubview(button)

            return button.tapPublisher.eraseToAnyPublisher()
        }

        Publishers.MergeMany(publishers)
            .sink { [weak self] seriesNumber in
                self?.seriesNumberButtonOnTapPublisher.send(seriesNumber)
            }
            .store(in: &cancellables)
    }

    func updateStates(with selectedSeriesNumber: Int) {
        arrangedSubviews
            .compactMap { $0 as? HPBSeriesNumberButton }
            .forEach {
                let isSelected = $0.currentTitle == "\(selectedSeriesNumber)"
                let state: HPBSeriesNumberButton.State = isSelected ? .selected : .unselected
                $0.updateLayout(with: state)
            }
    }
}

private extension HPBSeriesNumberButtonsView {
    func configure() {
        configureLayout()
    }

    func configureLayout() {
        spacing = 8
        distribution = .equalSpacing
    }
}
