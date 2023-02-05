//
//  HeaderView.swift
//  FoodApp
//
//  Created by Mobios on 2/3/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UICollectionReusableView {
    
    static let reusableId = "HeaderView"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties: -
    let headingLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.font = UIFont.boldSystemFont(ofSize:19)
        lb.textColor = .blue
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.scaleFont()
        return lb
    }()

    let headingButton: UIButton = {
           var btn = UIButton()
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        btn.backgroundColor = .blue
           btn.setTitle("All", for: .normal)
           btn.layer.cornerRadius = 5
           btn.translatesAutoresizingMaskIntoConstraints = false
           return btn
       }()
    
    func setupViews(){
        addSubview(headingButton)
        addSubview(headingLabel)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            headingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            headingButton.centerYAnchor.constraint(equalTo: centerYAnchor),
               headingButton.trailingAnchor.constraint(equalTo: trailingAnchor),
               headingButton.heightAnchor.constraint(equalToConstant: 20),
               headingButton.widthAnchor.constraint(equalToConstant: 30),
            
        ])
    }
}
