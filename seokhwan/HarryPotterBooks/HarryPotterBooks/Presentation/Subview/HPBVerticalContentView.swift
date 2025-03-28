import UIKit

final class HPBVerticalContentView: UIStackView {
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
    private lazy var moreButtonStackView = UIStackView()
    private lazy var spacer = UIView()
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("more", for: .normal)
        return button
    }()

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(_ type: HPBVerticalContentView.ContentsType) {
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

    func update(contents: String, isExpanded: Bool) {
        update(contents: contents)
        moreButton.setTitle(isExpanded ? "접기" : "더 보기", for: .normal)

    }
}

private extension HPBVerticalContentView {
    func configure(_ type: HPBVerticalContentView.ContentsType) {
        configureLayout(type)
        configureSubviews(type)
    }

    func configureLayout(_ type: HPBVerticalContentView.ContentsType) {
        axis = .vertical
        spacing = 8

        headerLabel.text = type.rawValue

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = type.lineSpacing
        contentsAttributes = [.paragraphStyle: paragraphStyle]
    }

    func configureSubviews(_ type: HPBVerticalContentView.ContentsType) {
        [headerLabel, contentsLabel].forEach {
            addArrangedSubview($0)
        }
        if type == .summary {
            [spacer, moreButton].forEach {
                moreButtonStackView.addArrangedSubview($0)
            }
            addArrangedSubview(moreButtonStackView)
        }
    }
}
