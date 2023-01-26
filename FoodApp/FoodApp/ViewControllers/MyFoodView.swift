//
//  MyFoodView.swift
//  FoodApp
//
//  Created by Mobios on 1/22/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import SwiftUI

struct MyFoodView: View {
    
    @ObservedObject var loginData : LoginData
    var controller = ApiController();
    @State var food : FoodItemModel = FoodItemModel(id: "0",food_id: 0, img: "", name: "",calories:0,isFav: false,description: "");
    @State var type = "";
    @State var viewOnly : Bool = false
    @State var myList  : [FoodItemModel]=[ FoodItemModel(id: .init(),food_id: 1, img: "https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466__340.jpg", name: "name",calories: 900,isFav: false,description: "")]
    
    var body: some View {
        
        ZStack(alignment: .center) {
                   
                    ScrollView(.vertical){
                        VStack{

                            Text("My Favorite").font(.headline).fontWeight(.bold)
                            ForEach(0..<myList.count, id: \.self) { index in
                                VStack{
                                    FoodCard(food:self.myList[index],loginData:self.loginData,showFooter: false)
                                }
                            }
                        }
                    }
                
            
            
    }.onAppear(){
        if(!self.viewOnly){
             self.controller.addFav(type:self.type, food_id: self.food.id, user: self.loginData.user)
        }
       
        self.myList = [];
        self.controller.getFoodFavList(type: "breakfast") { (success) in
            self.myList.append(contentsOf: success);
        }
        self.controller.getFoodFavList(type: "lunch") { (success) in
            self.myList.append(contentsOf: success);
        }
        self.controller.getFoodFavList(type: "dinner") { (success) in
            self.myList.append(contentsOf: success);
        }
        
    
        }.frame(
          minWidth: 0,
          maxWidth: .infinity,
          minHeight: 0,
          maxHeight: .infinity,
          alignment: .center
        )
}
}

struct MyFoodView_Previews: PreviewProvider {
    static var previews: some View {
        MyFoodView(loginData: LoginData())
    }
}
