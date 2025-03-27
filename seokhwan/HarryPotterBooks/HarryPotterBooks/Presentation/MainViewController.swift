import UIKit
import Combine
import SnapKit

final class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    private var cancellables = Set<AnyCancellable>()

    private lazy var headerView = HPBHeaderView()
    private lazy var scrollView = UIScrollView()
    private lazy var contentsView = HPBContainerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func updateContents(with book: Book) {
        headerView.updateContents(with: book)
        contentsView.updateContents(with: book)
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
        scrollView.addSubview(contentsView)
        [headerView, scrollView].forEach {
            view.addSubview($0)
        }
    }

    func configureConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(24)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentsView.snp.makeConstraints { make in
            make.directionalEdges.width.equalToSuperview()
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
