//
//  MainView.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/25/25.
//

import UIKit
import SnapKit
import Then

protocol MainViewDelegate: AnyObject {
    func mainViewDidTapReadMore()
}

final class MainView: UIView {

    weak var delegate: MainViewDelegate?
    
    private let bookOverviewView = BookOverviewView()
    private let bookDetailsView = BookDetailsView()
    private let bookChapterView = BookChapterView()
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.text = "Title"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    private let seriesButton = UIButton().then {
        $0.setTitleColor( .white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.backgroundColor = UIColor.systemBlue
        $0.setTitle("?", for: .normal)
        $0.isUserInteractionEnabled = false // 임시 레벨 1 기준 세팅
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        bookDetailsView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
        
        seriesButton.layer.cornerRadius = 16
    }
    
    private func setupHierarchy() {
        [titleLabel, seriesButton, scrollView].forEach { addSubview($0) }
        scrollView.addSubview(contentView)
        [bookOverviewView, bookDetailsView, bookChapterView].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().inset(20)
            $0.trailing.greaterThanOrEqualToSuperview().inset(20)
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
        }
        
        seriesButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.size.equalTo(32)
        }
        
        scrollView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalTo(seriesButton.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        bookOverviewView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5) // 요구사항대로 5만큼의 offset 조정
            $0.top.equalToSuperview().offset(12)
        }
        
        bookDetailsView.snp.makeConstraints {
            $0.top.equalTo(bookOverviewView.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        bookChapterView.snp.makeConstraints {
            $0.top.equalTo(bookDetailsView.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.bottom.equalTo(bookChapterView.snp.bottom).offset(20)
        }
    }
    
    func configure(book: Book, index: Int, readMoreState: Bool) {
        titleLabel.text = book.title
        seriesButton.setTitle(String(index), for: .normal)
        
        bookOverviewView.configure(book: book, index: index)
        bookDetailsView.configure(dedication: book.dedication, summary: book.summary, isReadMore: readMoreState)
        bookChapterView.configure(with: book.chapters)
    }
    
}

extension MainView: BookDetailsViewDelegate {
    func bookDetailsViewDidTapReadMore() {
        delegate?.mainViewDidTapReadMore()
    }
}
