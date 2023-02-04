//
//  Ext.swift
//  FoodApp
//
//  Created by Mobios on 2/3/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func addBorders(){
        let borderAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.borderWidth))
        borderAnimation.fromValue = 0.0
        borderAnimation.toValue = 2.0
        borderAnimation.duration = 0.4
        layer.borderWidth = 2.0
        layer.borderColor = color.green.cgColor
        layer.backgroundColor = UIColor.white.cgColor
        layer.add(borderAnimation, forKey: #keyPath(CALayer.borderWidth))
        becomeFirstResponder()
    }
    func removeBorders(){
        let borderAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.borderWidth))
        borderAnimation.fromValue = 0.0
        borderAnimation.toValue = 0.0
        borderAnimation.duration = 0.4
        layer.borderWidth = 0
        layer.borderColor = .none
        layer.add(borderAnimation, forKey: #keyPath(CALayer.borderWidth))
        layer.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.5).cgColor
        resignFirstResponder()
    }
}

extension UILabel {
    
    func addLetterSpacing (about spacing: Double){
        if let labelText = text, labelText.isEmpty == false {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length - 1))
        }
    }
    func scaleFont(){
        self.adjustsFontForContentSizeCategory = true
    }
}
