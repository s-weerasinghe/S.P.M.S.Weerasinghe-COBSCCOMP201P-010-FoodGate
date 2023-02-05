//
//  FoodViewCell.swift
//  FoodApp
//
//  Created by Mobios on 2/3/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import UIKit
import Kingfisher

class FoodCollectionViewCell: UICollectionViewCell {
    
    var data : FoodItemModel? {
        didSet{
            manageData()
        }
    }
    static let reusableId = "foodCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        foodDescriptionView.discountedContainer.isHidden = true
        imageDescriptionView.discountContainer.isHidden = true
        imageDescriptionView.overlayView.isHidden = true
    }
    
    let foodDescriptionView: FoodDescriptionDetailsView = {
        let v = FoodDescriptionDetailsView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let imageDescriptionView: FoodImageDetailsView = {
        let v = FoodImageDetailsView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func setupViews(){
        addSubview(imageDescriptionView)
        addSubview(foodDescriptionView)
        
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            imageDescriptionView.topAnchor.constraint(equalTo: topAnchor),
            imageDescriptionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageDescriptionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageDescriptionView.heightAnchor.constraint(equalToConstant: 200),
            
            foodDescriptionView.topAnchor.constraint(equalTo: imageDescriptionView.bottomAnchor,constant: 10),
            foodDescriptionView.leadingAnchor.constraint(equalTo:leadingAnchor),
            foodDescriptionView.trailingAnchor.constraint(equalTo:trailingAnchor),
            foodDescriptionView.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    func manageData(){
        guard let item = data else { return }
        foodDescriptionView.foodTitleLabel.text = item.name
        
        foodDescriptionView.discountedContainer.isHidden = true
        foodDescriptionView.ratingLabel.isHidden = true
        foodDescriptionView.actualPriceLabel.isHidden = true
        
        foodDescriptionView.ratingIcon.isHidden = !item.isFav
        
        imageDescriptionView.durationLabel.text = "calories - \(item.calories)"
        
        let url = URL(string: item.img)
        imageDescriptionView.foodImage.kf.setImage(with: url)
        
    }
    func setupAttributedText (_ price: String) -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(price)", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,NSAttributedString.Key.strikethroughColor: color.grey,.foregroundColor: color.grey]))
        return text
    }
}
