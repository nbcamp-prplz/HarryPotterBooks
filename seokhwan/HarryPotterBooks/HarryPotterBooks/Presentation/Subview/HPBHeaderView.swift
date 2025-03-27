import UIKit
import SnapKit

final class HPBHeaderView: UIView {
    private lazy var bookTitleLabel: UILabel = {
        let label = UILabel()

        label.text = "HarryPotterBooks"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()
    private lazy var seriesNumberButtonsStackView = UIStackView()
    private lazy var seriesNumberButton: UIButton = {
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 16)

        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = AttributedString("1", attributes: container)

        let button = UIButton(configuration: configuration)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true

        return button
    }()

    convenience init() {
        self.init(frame: .zero)
        configure()
    }

    func updateContents(with book: Book) {
        bookTitleLabel.text = book.title
        seriesNumberButton.configuration?.title = "\(book.seriesNumber)"
    }
}

private extension HPBHeaderView {
    func configure() {
        configureSubviews()
        configureConstraints()
    }

    func configureSubviews() {
        [seriesNumberButton].forEach {
            seriesNumberButtonsStackView.addArrangedSubview($0)
        }
        [bookTitleLabel, seriesNumberButtonsStackView].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        bookTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        seriesNumberButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(16)
            make.centerX.bottom.equalToSuperview()
        }
        seriesNumberButton.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
    }
}
