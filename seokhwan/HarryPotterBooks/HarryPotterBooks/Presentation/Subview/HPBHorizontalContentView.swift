import UIKit

final class HPBHorizontalContentView: UIStackView {
    enum ContentsType: String {
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

        var contentsFont: UIFont {
            switch self {
            case .author:
                return .systemFont(ofSize: 18)
            default:
                return .systemFont(ofSize: 14)
            }
        }

        var contentsTextColor: UIColor {
            switch self {
            case .author:
                return .darkGray
            default:
                return .gray
            }
        }
    }

    private lazy var headerLabel = UILabel()
    private lazy var contentsLabel = UILabel()

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(_ type: HPBHorizontalContentView.ContentsType) {
        self.init(frame: .zero)
        configure(type)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure(.none)
    }

    func update(contents: String) {
        contentsLabel.text = contents
    }
}

private extension HPBHorizontalContentView {
    func configure(_ type: HPBHorizontalContentView.ContentsType) {
        configureLayout(type)
        configureSubviews()
    }

    func configureLayout(_ type: HPBHorizontalContentView.ContentsType) {
        spacing = 8

        headerLabel.text = type.rawValue
        headerLabel.font = type.headerFont
        headerLabel.textColor = type.headerTextColor

        contentsLabel.font = type.contentsFont
        contentsLabel.textColor = type.contentsTextColor
    }

    func configureSubviews() {
        [headerLabel, contentsLabel].forEach {
            addArrangedSubview($0)
        }
    }
}
