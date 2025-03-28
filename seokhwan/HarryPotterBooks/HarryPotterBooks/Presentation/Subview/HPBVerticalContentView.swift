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

    var moreButtonTapAction: (() -> Void)?

    private var contentsType: ContentsType = .none
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
        button.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        return button
    }()

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(_ contentsType: HPBVerticalContentView.ContentsType) {
        self.init(frame: .zero)
        self.contentsType = contentsType
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func update(contents: String, isExpanded: Bool = false) {
        let maxContentsCount = 450
        let shouldShowMoreButton = contentsType == .summary && contents.count >= maxContentsCount
        let shouldTruncateContents = shouldShowMoreButton && !isExpanded

        moreButtonStackView.isHidden = !shouldShowMoreButton
        moreButton.setTitle(isExpanded ? "접기" : "더 보기", for: .normal)

        let truncatedContents = shouldTruncateContents ? contents.prefix(maxContentsCount) + "..." : contents
        let attributedString = NSAttributedString(string: truncatedContents, attributes: contentsAttributes)
        contentsLabel.attributedText = attributedString
    }

    @objc private func didTapMoreButton() {
        moreButtonTapAction?()
    }
}

private extension HPBVerticalContentView {
    func configure() {
        configureLayout()
        configureSubviews()
    }

    func configureLayout() {
        axis = .vertical
        spacing = 8

        headerLabel.text = contentsType.rawValue

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = contentsType.lineSpacing
        contentsAttributes = [.paragraphStyle: paragraphStyle]
    }

    func configureSubviews() {
        [spacer, moreButton].forEach {
            moreButtonStackView.addArrangedSubview($0)
        }
        [headerLabel, contentsLabel, moreButtonStackView].forEach {
            addArrangedSubview($0)
        }
    }
}
