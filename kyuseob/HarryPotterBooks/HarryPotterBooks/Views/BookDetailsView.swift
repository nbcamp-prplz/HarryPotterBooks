//
//  BookInfoBottomView.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/27/25.
//

import UIKit

protocol BookDetailsViewDelegate: AnyObject {
    func bookDetailsViewDidTapReadMore(index: Int)
}

class BookDetailsView: UIView {
    
    weak var delegate: BookDetailsViewDelegate?
    
    private var isReadMore: Bool?
    private var currentIndex: Int = 0
    
    private let dedicationStackView = TitleContentView()
    private let summaryStackView = TitleContentView()
    private let readMoreButton = UIButton().then {
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        [dedicationStackView, summaryStackView, readMoreButton].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        dedicationStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        summaryStackView.snp.makeConstraints {
            $0.top.equalTo(dedicationStackView.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        readMoreButton.snp.makeConstraints {
            $0.trailing.equalTo(summaryStackView.snp.trailing)
            $0.top.equalTo(summaryStackView.snp.bottom).offset(8)
        }
        
        self.snp.makeConstraints {
            $0.bottom.equalTo(readMoreButton.snp.bottom)
        }
    }
    
    private func setupAction() {
        readMoreButton.addTarget(self, action: #selector(didTapReadMoreButton), for: .touchUpInside)
    }

    func configure(dedication: String, summary: String, isReadMore: Bool, index: Int) {
        self.isReadMore = isReadMore
        self.currentIndex = index
        dedicationStackView.configure(title: "Dedication", content: dedication)
        summaryStackView.configure(title: "Summary", content: summary)
        summaryStackView.setExpandedLabel(isExpanded: isReadMore)
         
        readMoreButton.isHidden = summaryStackView.contentLength() <= 450 ? true : false
        readMoreButton.setTitle(isReadMore ? "접기" : "더보기", for: .normal)
    }
    
    @objc private func didTapReadMoreButton() {
        delegate?.bookDetailsViewDidTapReadMore(index: currentIndex) // viewModel 측 데이터 변경은 viewController에서 할 수 있도록

        self.isReadMore?.toggle()
        
        guard let isReadMore else { return } // 이후 코드들의 파라미터는 옵셔널을 받을 수 없어 언래핑
        summaryStackView.setExpandedLabel(isExpanded: isReadMore)
        readMoreButton.setTitle(isReadMore ? "접기" : "더보기", for: .normal)
    }
    
}
