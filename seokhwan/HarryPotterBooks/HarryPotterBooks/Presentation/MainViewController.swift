import UIKit
import Combine
import SnapKit

final class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    private var cancellables = Set<AnyCancellable>()

    private lazy var bookTitleLabel: UILabel = {
        let label = UILabel()

        label.text = "HarryPotterBooks"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

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
    private lazy var bookInformationView = BookInformationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func presentErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)

        present(alert, animated: true)
    }
}

private extension MainViewController {
    func configure() {
        configureLayout()
        configureSubviews()
        configureConstraints()
        configureBind()
    }

    func configureLayout() {
        view.backgroundColor = .systemBackground
    }

    func configureSubviews() {
        [seriesNumberButton].forEach {
            seriesNumberButtonsStackView.addArrangedSubview($0)
        }
        [bookTitleLabel, seriesNumberButtonsStackView, bookInformationView].forEach {
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
        bookInformationView.snp.makeConstraints { make in
            make.top.equalTo(seriesNumberButtonsStackView.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
    }

    func configureBind() {
        viewModel.$bookTitle
            .sink { [weak self] bookTitle in
                self?.bookTitleLabel.text = bookTitle
            }
            .store(in: &cancellables)
        viewModel.$seriesNumber
            .sink { [weak self] seriesNumber in
                self?.seriesNumberButton.configuration?.title = seriesNumber
            }
            .store(in: &cancellables)
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                if let errorMessage {
                    self?.presentErrorAlert(with: errorMessage)
                }
            }
            .store(in: &cancellables)
    }
}
