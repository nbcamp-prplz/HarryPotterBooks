import UIKit
import Combine
import SnapKit

final class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    private var cancellables = Set<AnyCancellable>()

    private lazy var headerView = HPBHeaderView()
    private lazy var scrollView = UIScrollView()
    private lazy var containerView = HPBContainerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func generateSeriesNumberButtons(with count: Int) {
        headerView.generateSeriesNumberButtons(numberOf: count)
    }

    private func updateContents(with book: Book) {
        headerView.updateContents(with: book)
        containerView.updateContents(with: book)
    }
}

private extension MainViewController {
    func configure() {
        configureLayout()
        configureSubviews()
        configureConstraints()
        configureBind()
        configureActions()
    }

    func configureLayout() {
        view.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = false
    }

    func configureSubviews() {
        scrollView.addSubview(containerView)
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
        containerView.snp.makeConstraints { make in
            make.directionalEdges.width.equalToSuperview()
        }
    }

    func configureBind() {
        viewModel.numberOfBooks
            .sink { [weak self] count in
                Task {
                    await MainActor.run {
                        self?.generateSeriesNumberButtons(with: count)
                    }
                }
            }
            .store(in: &cancellables)
        viewModel.selectedBook
            .compactMap { $0 }
            .sink { [weak self] book in
                Task {
                    await MainActor.run {
                        self?.updateContents(with: book)
                    }
                }
            }
            .store(in: &cancellables)
        viewModel.errorMessage
            .compactMap { $0 }
            .sink { [weak self] errorMessage in
                Task {
                    await MainActor.run {
                        self?.presentErrorAlert(with: errorMessage)
                    }
                }
            }
            .store(in: &cancellables)
    }

    func configureActions() {
        containerView.moreButtonOnTap = { [weak self] in
            self?.viewModel.toggleExpandedStateOfSelectedBook()
        }
    }
}
