//
//  FoodLayout.swift
//  FoodApp
//
//  Created by Mobios on 2/3/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import Foundation
import UIKit
class FoodLayout {
    
    static let shared = FoodLayout()
    
    private init() {}
    
    
    func foodLayout () -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
                       
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(250), heightDimension: .absolute(250)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 0, leading: 30, bottom: 0, trailing: 30)
        section.orthogonalScrollingBehavior = .continuous
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(70)), elementKind: HeaderView.reusableId, alignment: .top)
        ]
        return section
    }

    
    func defaultLayout () -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(100), heightDimension: .absolute(170)), subitems: [item])
       
        let section = NSCollectionLayoutSection.init(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}
