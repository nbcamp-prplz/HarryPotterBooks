import UIKit

final class HPBVerticalContentsView: UIStackView {
    enum ContentsType: String {
        case none
        case dedication = "Dedication"
        case summary = "Summary"
        case chapters = "Chapters"

        var lineSpacing: CGFloat {
            switch self {
            case .chapters:
                return 8
            default:
                return 0
            }
        }
    }

    private var contentsAttributes = [NSAttributedString.Key: Any]()

    private lazy var headerLabel: UILabel = {
        let label = UILabel()

        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black

        return label
    }()
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(_ type: HPBVerticalContentsView.ContentsType) {
        self.init(frame: .zero)
        configure(type)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure(.none)
    }

    func update(contents: String) {
        let attributedString = NSAttributedString(string: contents, attributes: contentsAttributes)
        contentsLabel.attributedText = attributedString
    }
}

private extension HPBVerticalContentsView {
    func configure(_ type: HPBVerticalContentsView.ContentsType) {
        configureLayout(type)
        configureSubviews()
    }

    func configureLayout(_ type: HPBVerticalContentsView.ContentsType) {
        axis = .vertical
        spacing = 8

        headerLabel.text = type.rawValue

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = type.lineSpacing
        contentsAttributes = [.paragraphStyle: paragraphStyle]
    }

    func configureSubviews() {
        [headerLabel, contentsLabel].forEach {
            addArrangedSubview($0)
        }
    }
}
