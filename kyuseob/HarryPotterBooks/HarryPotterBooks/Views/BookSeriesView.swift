//
//  BookSeriesView.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/28/25.
//

import UIKit

protocol BookSeriesViewDelegate: AnyObject {
    func didChangeSelectedIndex(to index: Int)
}

class BookSeriesView: UIView {
    
    weak var delegate: BookSeriesViewDelegate?
    
    private var seriesCount: Int = 0
    private var selectedIndex: Int = 0
    private var buttons: [UIButton] = []
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
    }
    
    private func createSeriesButtons() {
        buttons.removeAll()
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for i in 0..<seriesCount {
            let button = UIButton()
            button.setTitle(String(i + 1), for: .normal)
            button.backgroundColor = i == selectedIndex ? .systemBlue : .lightGray.withAlphaComponent(0.2) // hex값으로 lightGray보다 더 밝게하는 것 대신 투명도 조절을 선택함
            button.setTitleColor(i == selectedIndex ? .white : .systemBlue, for: .normal)
            button.snp.makeConstraints { make in
                make.size.equalTo(38)
            }
            button.layer.cornerRadius = 19
            let action = UIAction { [weak self] _ in
                self?.didTapSeriesButton(button, index: i)
            }
            button.addAction(action, for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons.forEach { stackView.addArrangedSubview($0) }
    }
    
    func configure(_ count: Int) {
        self.seriesCount = count

        createSeriesButtons()
    }
    
    private func didTapSeriesButton(_ sender: UIButton, index: Int) {
        self.selectedIndex = index
        delegate?.didChangeSelectedIndex(to: index)
    }
    
}
