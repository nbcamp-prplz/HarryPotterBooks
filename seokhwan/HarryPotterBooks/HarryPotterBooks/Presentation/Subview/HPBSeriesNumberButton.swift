import UIKit
import Combine
import SnapKit

final class HPBSeriesNumberButton: UIButton {
    enum State {
        case selected
        case unselected

        var titleColor: UIColor {
            switch self {
            case .selected:
                return .white
            case .unselected:
                return .systemBlue
            }
        }

        var backgroundColor: UIColor {
            switch self {
            case .selected:
                return .systemBlue
            case .unselected:
                return .systemGray5
            }
        }
    }

    let tapPublisher = PassthroughSubject<Int, Never>()

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(seriesNumber: Int) {
        self.init(frame: .zero)
        configure(seriesNumber: seriesNumber)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func updateLayout(with state: State) {
        setTitleColor(state.titleColor, for: .normal)
        backgroundColor = state.backgroundColor
    }

    @objc func didTap() {
        guard let seriesNumber = Int(currentTitle ?? "") else { return }
        tapPublisher.send(seriesNumber)
    }
}

private extension HPBSeriesNumberButton {
    func configure(seriesNumber: Int) {
        configureLayout(seriesNumber)
        configureConstraints()
        configureActions()
    }

    func configureLayout(_ seriesNumber: Int) {
        setTitle("\(seriesNumber)", for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16)
        layer.cornerRadius = 22
        layer.masksToBounds = true
    }

    func configureConstraints() {
        snp.makeConstraints { make in
            make.size.equalTo(44)
        }
    }

    func configureActions() {
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
}
