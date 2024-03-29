//
//  EmptyAddressesView.swift
//  ECommerce
//
//  Created by Alex on 2.07.2023.
//

import UIKit

protocol EmptyAddressesViewButtonDelegate: AnyObject {
    func toAddButtonTapped()
}

final class EmptyAddressesView: UIView {
        
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .label
        label.text = "You haven't added addresses yet!"
        label.font = .systemFont(ofSize: 20, weight: .thin)
        return label
    }()
    
    private lazy var toAddButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBackground, for: .normal)
        button.setTitle("+ Add Address", for: .normal)
        button.backgroundColor = .label
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.titleEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.addTarget(self, action: #selector(toAddButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var VStackView: VerticalStackView = {
        let stackView = VerticalStackView(arrangedSubviews: [infoLabel, toAddButton], spacing: 16)
        stackView.alignment = .center
        return stackView
    }()
    
    weak var delegate: EmptyAddressesViewButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(VStackView)
        
        toAddButton.snp.makeConstraints { make in
            make.width.equalTo(148)
            make.height.equalTo(40)
        }
        
        VStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc
    private func toAddButtonTapped(_ sender: UIButton) {
        delegate?.toAddButtonTapped()
    }
}
