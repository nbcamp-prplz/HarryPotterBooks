import UIKit
import SnapKit

final class BookInformationView: UIStackView {
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "book.fill")
        return imageView
    }()
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
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
    private lazy var authorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        return stackView
    }()
    private lazy var authorHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    private lazy var authorContentsLabel: UILabel = {
        let label = UILabel()
        label.text = "author contents"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    private lazy var releasedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        return stackView
    }()
    private lazy var releasedHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Released"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    private lazy var releasedContentsLabel: UILabel = {
        let label = UILabel()
        label.text = "released contents"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    private lazy var pagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        return stackView
    }()
    private lazy var pagesHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Pages"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    private lazy var pagesContentsLabel: UILabel = {
        let label = UILabel()
        label.text = "pages contents"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

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
        authorContentsLabel.text = book.author
        releasedContentsLabel.text = book.releaseDate.toReleasedString()
        pagesContentsLabel.text = "\(book.pages)"
    }
}

private extension BookInformationView {
    func configure() {
        configureLayout()
        configureSubviews()
        configureConstraints()
    }

    func configureLayout() {
        axis = .horizontal
        spacing = 10
        alignment = .top
    }

    func configureSubviews() {
        [authorHeaderLabel, authorContentsLabel].forEach {
            authorStackView.addArrangedSubview($0)
        }
        [releasedHeaderLabel, releasedContentsLabel].forEach {
            releasedStackView.addArrangedSubview($0)
        }
        [pagesHeaderLabel, pagesContentsLabel].forEach {
            pagesStackView.addArrangedSubview($0)
        }
        [titleLabel, authorStackView, releasedStackView, pagesStackView].forEach {
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
