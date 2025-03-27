import UIKit
import SnapKit

final class HPBInformationView: UIStackView {
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "book.fill")

        return imageView
    }()
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading

        return stackView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.text = "title"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black

        return label
    }()
    private lazy var authorView = HPBHorizontalContentsView(.author)
    private lazy var releasedView = HPBHorizontalContentsView(.released)
    private lazy var pagesView = HPBHorizontalContentsView(.pages)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func updateContents(with book: Book) {
        coverImageView.image = UIImage(named: "harrypotter\(book.seriesNumber)")
        titleLabel.text = book.title
        authorView.update(contents: book.author)
        releasedView.update(contents: book.releaseDate.releasedString())
        pagesView.update(contents: "\(book.pages)")
    }
}

private extension HPBInformationView {
    func configure() {
        configureLayout()
        configureSubviews()
        configureConstraints()
    }

    func configureLayout() {
        axis = .horizontal
        spacing = 15
        alignment = .top
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
    }

    func configureSubviews() {
        [titleLabel, authorView, releasedView, pagesView].forEach {
            informationStackView.addArrangedSubview($0)
        }
        [coverImageView, informationStackView].forEach {
            addArrangedSubview($0)
        }
    }

    func configureConstraints() {
        coverImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(coverImageView.snp.width).multipliedBy(1.5)
        }
    }
}
