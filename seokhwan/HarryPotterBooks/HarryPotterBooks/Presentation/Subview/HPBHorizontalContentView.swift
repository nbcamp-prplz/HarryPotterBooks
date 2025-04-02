import UIKit

final class HPBHorizontalContentView: UIStackView {
    enum ContentType: String {
        case none
        case author = "Author"
        case released = "Released"
        case pages = "Pages"

        var headerFont: UIFont {
            switch self {
            case .author:
                return .boldSystemFont(ofSize: 16)
            default:
                return .boldSystemFont(ofSize: 14)
            }
        }

        var headerTextColor: UIColor {
            return .black
        }

        var contentFont: UIFont {
            switch self {
            case .author:
                return .systemFont(ofSize: 18)
            default:
                return .systemFont(ofSize: 14)
            }
        }

        var contentTextColor: UIColor {
            switch self {
            case .author:
                return .darkGray
            default:
                return .gray
            }
        }
    }

    private lazy var headerLabel = UILabel()
    private lazy var contentLabel = UILabel()

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(_ type: HPBHorizontalContentView.ContentType) {
        self.init(frame: .zero)
        configure(type)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure(.none)
    }

    func update(content: String) {
        contentLabel.text = content
    }
}

private extension HPBHorizontalContentView {
    func configure(_ type: HPBHorizontalContentView.ContentType) {
        configureLayout(type)
        configureSubviews()
    }

    func configureLayout(_ type: HPBHorizontalContentView.ContentType) {
        spacing = 8

        headerLabel.text = type.rawValue
        headerLabel.font = type.headerFont
        headerLabel.textColor = type.headerTextColor

        contentLabel.font = type.contentFont
        contentLabel.textColor = type.contentTextColor
    }

    func configureSubviews() {
        [headerLabel, contentLabel].forEach {
            addArrangedSubview($0)
        }
    }
}
