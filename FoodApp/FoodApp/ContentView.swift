//
//  ContentView.swift
//  FoodApp
//
//  Created by Sweerasinghe on 1/13/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var loginData : LoginData
    var body: some View {
        HomeView(loginData: loginData).onAppear(){
        }
         
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(loginData: LoginData())
    }
}
