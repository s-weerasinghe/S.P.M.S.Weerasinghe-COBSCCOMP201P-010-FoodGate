//
//  FoodDetailView.swift
//  FoodApp
//
//  Created by Mobios on 1/22/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import SwiftUI

struct FoodDetailView: View {
    @ObservedObject var loginData : LoginData
    var controller = ApiController();
    @State var food : FoodItemModel = FoodItemModel(id: "0",food_id: 0, img: "", name: "fgdfgdfgdgdfgd",calories:0,isFav: false,description: "bfghfghfghfghfghfghfghcvbcvbdfgdfgdfgdfgdfgdfg");
    @State var type = "";
    
    var body: some View {
        
        ZStack {
            VStack{
                AsyncImage(urlString: food.img)
                    .frame(width: 300, height: 250, alignment: .center)
                Section(header: Text("Information")) {
                    ScrollView(.vertical){
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("Name - ").padding(.trailing, 5.0)
                                Text(food.name)
                            }.padding(5)
                            HStack {
                                Text("Calories - ").padding(.trailing, 5.0)
                                Text(String(food.calories))
                            }.padding(5)
                            HStack {
                                Text("Description - ").padding(.trailing, 5.0)
                                Text(food.description)
                            }.padding(5)
                        }
                        
                    }
                }.padding(10.0)
            }
        }.onAppear(){
            
            
        }
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(loginData: LoginData())
    }
}
