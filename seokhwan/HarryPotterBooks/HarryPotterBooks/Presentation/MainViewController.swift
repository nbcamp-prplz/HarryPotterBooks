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
    private lazy var informationView = HPBInformationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func updateContents(with book: Book) {
        bookTitleLabel.text = book.title
        seriesNumberButton.configuration?.title = "\(book.seriesNumber)"
        informationView.updateContents(with: book)
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
        [bookTitleLabel, seriesNumberButtonsStackView, informationView].forEach {
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
        informationView.snp.makeConstraints { make in
            make.top.equalTo(seriesNumberButtonsStackView.snp.bottom).offset(24)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
    }

    func configureBind() {
        viewModel.$selectedBook
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] book in
                self?.updateContents(with: book)
            }
            .store(in: &cancellables)
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] errorMessage in
                self?.presentErrorAlert(with: errorMessage)
            }
            .store(in: &cancellables)
    }
}
