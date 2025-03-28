import UIKit
import SnapKit

final class HPBHeaderView: UIView {
    private lazy var bookTitleLabel: UILabel = {
        let label = UILabel()

        label.text = "HarryPotterBooks"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()
    private lazy var seriesNumberButtonsView = HPBSeriesNumberButtonsView()

    convenience init() {
        self.init(frame: .zero)
        configure()
    }

    func generateSeriesNumberButtons(numberOf count: Int) {
        seriesNumberButtonsView.generateSeriesNumberButtons(numberOf: count)
    }

    func updateContents(with book: Book) {
        bookTitleLabel.text = book.title
        seriesNumberButtonsView.updateStates(with: book.seriesNumber)
    }
}

private extension HPBHeaderView {
    func configure() {
        configureSubviews()
        configureConstraints()
    }

    func configureSubviews() {
        [bookTitleLabel, seriesNumberButtonsView].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        bookTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        seriesNumberButtonsView.snp.makeConstraints { make in
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(16)
            make.centerX.bottom.equalToSuperview()
        }
    }
}
