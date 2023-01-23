//
//  ImageModel.swift
//  FoodApp
//
//  Created by Mobios on 1/23/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import Foundation
struct FoodModel:Identifiable {
    var id: String = UUID().uuidString
    
    var food_id: Int
    var img: String
    var name: String
    
    
    init(food_id: Int, img: String,name:String) {
        self.food_id = food_id
        self.name = name
        self.img = img

    }
}
