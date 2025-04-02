import UIKit
import Combine

final class SeriesNumberButtonsView: UIStackView {
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
        // 버튼들을 재할당하기 위해 기존 버튼들 제거
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }

        let publishers = (1...count).map {
            let button = SeriesNumberButton(seriesNumber: $0)
            addArrangedSubview(button)

            return button.tapPublisher.eraseToAnyPublisher() // [PassthroughSubject]를 [AnyPublisher]로 변환
        }

        // 각 버튼들의 Publisher를 따로따로 구독하지 않고, 하나의 스트림으로 처리할 수 있도록 merge
        Publishers.MergeMany(publishers)
            .sink { [weak self] seriesNumber in
                self?.seriesNumberButtonOnTapPublisher.send(seriesNumber)
            }
            .store(in: &cancellables)
    }

    func updateStates(with selectedSeriesNumber: Int) {
        arrangedSubviews
            .compactMap { $0 as? SeriesNumberButton }
            .forEach {
                let isSelected = $0.currentTitle == "\(selectedSeriesNumber)"
                let state: SeriesNumberButton.State = isSelected ? .selected : .unselected
                $0.updateLayout(with: state)
            }
    }
}

private extension SeriesNumberButtonsView {
    func configure() {
        configureLayout()
    }

    func configureLayout() {
        spacing = 8
        distribution = .equalSpacing
    }
}
