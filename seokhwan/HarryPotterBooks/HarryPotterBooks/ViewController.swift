import UIKit
import SnapKit

final class ViewController: UIViewController {
    private lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "HarryPotterBooks"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    private lazy var seriesNumberButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()

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

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension ViewController {
    func configure() {
        configureLayout()
        configureSubviews()
        configureConstraints()
    }

    func configureLayout() {
        view.backgroundColor = .systemBackground
    }

    func configureSubviews() {
        [seriesNumberButton].forEach {
            seriesNumberButtonsStackView.addArrangedSubview($0)
        }
        [bookTitleLabel, seriesNumberButtonsStackView].forEach {
            view.addSubview($0)
        }
    }

    func configureConstraints() {
        bookTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        seriesNumberButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(16)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        seriesNumberButton.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
    }
}
