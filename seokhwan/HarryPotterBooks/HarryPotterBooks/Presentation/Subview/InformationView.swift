import UIKit
import SnapKit

final class InformationView: UIStackView {
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "book.fill") // placeholder

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
    private lazy var authorView = HorizontalContentView(.author)
    private lazy var releasedView = HorizontalContentView(.released)
    private lazy var pagesView = HorizontalContentView(.pages)

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
        authorView.update(content: book.author)
        releasedView.update(content: book.releaseDate.releasedString()) // 'June 26, 1997'로 formatting
        pagesView.update(content: "\(book.pages)")
    }
}

private extension InformationView {
    func configure() {
        configureLayout()
        configureSubviews()
        configureConstraints()
    }

    func configureLayout() {
        axis = .horizontal
        spacing = 15
        alignment = .top
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
