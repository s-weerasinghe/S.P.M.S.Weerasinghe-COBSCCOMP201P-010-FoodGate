//
//  FoodItemModel.swift
//  FoodApp
//
//  Created by Mobios on 1/23/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import Foundation
import Foundation
struct FoodItemModel:Identifiable {
    var id: String = UUID().uuidString
    var food_id: Int
    var img: String
    var name: String
}
