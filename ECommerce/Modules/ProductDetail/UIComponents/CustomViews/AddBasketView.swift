//
//  AddBasketView.swift
//  ECommerce
//
//  Created by Alex on 29.06.2023.
//

import UIKit

protocol AddBasketButtonDelegate: AnyObject {
    func addBasketTapped()
}

final class AddBasketView: UIView {
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.backgroundColor = .label
        label.textColor = .secondarySystemBackground
        label.textAlignment = .center
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Basket", for: .normal)
        button.backgroundColor = .label
        button.setTitleColor(.secondarySystemBackground, for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.setImage(UIImage(systemName: "cart")?.withTintColor(.secondarySystemBackground, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.shadowOpacity = 0
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel,
                                                      addButton])
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    weak var delegate: AddBasketButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setConstraint()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint() {
        addSubview(stackView)
        
        priceLabel.snp.makeConstraints { make in
            make.height.equalTo(addButton)
        }
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(UIScreenBounds.width / 2.1)
            make.height.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(26)
            make.left.right.equalToSuperview().inset(26)
        }
    }
    
    @objc private func addButtonTapped() {
        delegate?.addBasketTapped()
    }
}
