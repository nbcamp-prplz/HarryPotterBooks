import UIKit
import Combine

final class VerticalContentView: UIStackView {
    enum ContentType: String {
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

    let moreButtonTapPublisher = PassthroughSubject<Void, Never>()

    private var contentType: ContentType = .none
    private var contentAttributes = [NSAttributedString.Key: Any]()

    private lazy var headerLabel: UILabel = {
        let label = UILabel()

        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black

        return label
    }()
    private lazy var contentLabel: UILabel = {
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
        button.accessibilityIdentifier = "moreButton"

        return button
    }()

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(_ contentType: VerticalContentView.ContentType) {
        self.init(frame: .zero)
        self.contentType = contentType
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func update(content: String, isExpanded: Bool = false) {
        let maxContentCount = 450
        let shouldShowMoreButton = contentType == .summary && content.count >= maxContentCount
        let shouldTruncateContent = shouldShowMoreButton && !isExpanded

        moreButtonStackView.isHidden = !shouldShowMoreButton
        UIView.performWithoutAnimation {
            moreButton.setTitle(isExpanded ? "접기" : "더 보기", for: .normal)
            moreButton.layoutIfNeeded()
        }

        let truncatedContent = shouldTruncateContent ? content.prefix(maxContentCount) + "..." : content
        let attributedString = NSAttributedString(string: truncatedContent, attributes: contentAttributes)
        contentLabel.attributedText = attributedString
    }

    @objc private func didTapMoreButton() {
        moreButtonTapPublisher.send()
    }
}

private extension VerticalContentView {
    func configure() {
        configureLayout()
        configureSubviews()
    }

    func configureLayout() {
        axis = .vertical
        spacing = 8

        headerLabel.text = contentType.rawValue
        contentLabel.accessibilityIdentifier = "contentLabelOf\(contentType.rawValue)"

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = contentType.lineSpacing
        contentAttributes = [.paragraphStyle: paragraphStyle]
    }

    func configureSubviews() {
        [spacer, moreButton].forEach {
            moreButtonStackView.addArrangedSubview($0)
        }
        [headerLabel, contentLabel, moreButtonStackView].forEach {
            addArrangedSubview($0)
        }
    }
}
