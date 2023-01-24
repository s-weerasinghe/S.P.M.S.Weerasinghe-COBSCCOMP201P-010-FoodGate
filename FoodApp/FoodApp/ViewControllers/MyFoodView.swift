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
    @State var food : FoodItemModel = FoodItemModel(id: "0",food_id: 0, img: "", name: "",calories:0,isFav: false);
    @State var type = "";
    @State var myList  =  [FoodItemModel]()
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical){
                VStack(alignment: .center){
                    Text("Favorite").font(.headline).fontWeight(.bold)
                    ScrollView(.vertical){
                        VStack{
                            ForEach(self.myList, id: \.id) { result in
                                HStack {
                                    FoodCard(food:result,loginData:self.loginData)
                                }
                            }
                        }.onAppear(){
                            print("sss")
                            
                            self.controller.getFoodFavList(type:"lunch"){(success) -> Void in
                                                         
                                                       self.myList = success;
                                                       print(self.myList)
                                                   }
                        }
                    }
                    
                }
            
            }.onAppear(){
                       
                            self.controller.addFav(type:self.type, food_id: self.food.id, user: self.loginData.user)
                            
                //            self.controller.getFoodFavList(type:"breakfast"){(success) -> Void in
                //
                //                self.myList.append(contentsOf: success);
                //                print(self.myList)
                //            }
                //
                //            self.controller.getFoodFavList(type:"dinner"){(success) -> Void in
                //                self.myList.append(contentsOf: success);
                //
                //                print(self.myList)
                //            }
                            
                       
                            print(self.myList)
            }
        }
    }
    
}

struct MyFoodView_Previews: PreviewProvider {
    static var previews: some View {
        MyFoodView(loginData: LoginData())
    }
}
