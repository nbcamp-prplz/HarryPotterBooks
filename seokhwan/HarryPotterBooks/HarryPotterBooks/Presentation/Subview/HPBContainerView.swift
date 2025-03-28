import UIKit

final class HPBContainerView: UIStackView {
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
        dedicationView.update(contents: book.dedication)
        summaryView.update(contents: book.summary)
        chaptersView.update(contents: book.chapters.joinedTitles)
    }
}

private extension HPBContainerView {
    func configure() {
        configureLayout()
        configureSubviews()
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
}
