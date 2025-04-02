import UIKit
import Combine
import SnapKit

final class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    private var cancellables = Set<AnyCancellable>()

    private lazy var headerView = HeaderView()
    private lazy var scrollView = UIScrollView()
    private lazy var containerView = ContainerView()

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
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20) // leading + trailing
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(24)
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20) // leading + trailing
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        containerView.snp.makeConstraints { make in
            make.directionalEdges.width.equalToSuperview() // top + leading + bottom + trailing
        }
    }

    func configureBind() {
        viewModel.numberOfBooks
            .sink { [weak self] count in
                Task {
                    await MainActor.run { // Main Thread에서 실행
                        self?.generateSeriesNumberButtons(with: count)
                    }
                }
            }
            .store(in: &cancellables)
        viewModel.selectedBook
            .compactMap { $0 }
            .sink { [weak self] book in
                guard let self else { return }
                Task {
                    await MainActor.run { // Main Thread에서 실행
                        // 부드럽게 전환되도록 애니메이션 지정
                        UIView.transition(with: self.view, duration: 0.1, options: .transitionCrossDissolve) {
                            self.updateContents(with: book)
                        }
                    }
                }
            }
            .store(in: &cancellables)
        viewModel.errorMessage
            .compactMap { $0 }
            .sink { [weak self] errorMessage in
                Task {
                    await MainActor.run { // Main Thread에서 실행
                        self?.presentErrorAlert(with: errorMessage)
                    }
                }
            }
            .store(in: &cancellables)
        headerView.seriesNumberButtonTapPublisher
            .sink { [weak self] seriesNumber in
                self?.viewModel.selectBook(at: seriesNumber)
            }
            .store(in: &cancellables)
        containerView.moreButtonTapPublisher
            .sink { [weak self] in
                self?.viewModel.toggleExpandedStateOfSelectedBook()
            }
            .store(in: &cancellables)
    }
}
