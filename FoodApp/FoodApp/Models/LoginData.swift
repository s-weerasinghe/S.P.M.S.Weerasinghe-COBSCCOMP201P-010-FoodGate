//
//  LoginData.swift
//  FoodApp
//
//  Created by Mobios on 1/23/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import Foundation
class LoginData: ObservableObject{
    @Published var loginState = false;
    @Published var user : UserModel = UserModel(regid: 0, age: "", name: "", email: "");
    @Published var reloadUI = false;
}
