import UIKit

final class HPBSeriesNumberButtonsView: UIStackView {
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

        (1...count)
            .map { HPBSeriesNumberButton(seriesNumber: $0) }
            .forEach {
                addArrangedSubview($0)
            }
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
