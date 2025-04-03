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
        label.numberOfLines = 0 // multiline 설정
        label.lineBreakMode = .byWordWrapping

        return label
    }()
    private lazy var moreButtonStackView = UIStackView()
    private lazy var spacer = UIView()
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)

        button.setTitle("more", for: .normal)
        button.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        button.accessibilityIdentifier = "moreButton" // UITest를 위한 identifier

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
        UIView.performWithoutAnimation { // 상위 View의 애니메이션과 충돌하여 Button의 애니메이션은 비활성화함
            moreButton.setTitle(isExpanded ? "접기" : "더 보기", for: .normal)
            moreButton.layoutIfNeeded() // 애니메이션이 없을 경우, 바로 반영해주지 않으면 다음 RunLoop까지 올바르지 않은 UI가 표시될 수 있음
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
        contentLabel.accessibilityIdentifier = "contentLabelOf\(contentType.rawValue)" // UITest를 위한 identifier

        // 단락 스타일을 지정하여 Label의 줄간격 지정
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
