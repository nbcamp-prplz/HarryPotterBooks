import UIKit
import Combine

final class HPBContainerView: UIStackView {
    let moreButtonTapPublisher = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()

    private lazy var informationView = HPBInformationView()
    private lazy var dedicationView = HPBVerticalContentView(.dedication)
    private lazy var summaryView = HPBVerticalContentView(.summary)
    private lazy var chaptersView = HPBVerticalContentView(.chapters)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func updateContents(with book: Book) {
        informationView.updateContents(with: book)
        dedicationView.update(content: book.dedication)
        summaryView.update(content: book.summary, isExpanded: book.isExpanded)
        chaptersView.update(content: book.chapters.joinedTitles)
    }
}

private extension HPBContainerView {
    func configure() {
        configureLayout()
        configureSubviews()
        configureBind()
    }

    func configureLayout() {
        axis = .vertical
        spacing = 24
    }

    func configureSubviews() {
        [informationView, dedicationView, summaryView, chaptersView].forEach {
            addArrangedSubview($0)
        }
    }

    func configureBind() {
        summaryView.moreButtonTapPublisher
            .sink { [weak self] in
                self?.moreButtonTapPublisher.send()
            }
            .store(in: &cancellables)
    }
}
