//
//  UserModel.swift
//  FoodApp
//
//  Created by Mobios on 1/23/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import Foundation
struct UserModel: Identifiable {
    var id: String = UUID().uuidString
    var regid: Int
    var age: String
    var name: String
    var email: String
}
