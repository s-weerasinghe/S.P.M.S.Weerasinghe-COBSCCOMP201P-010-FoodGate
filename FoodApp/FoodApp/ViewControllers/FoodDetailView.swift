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
    @State var food : FoodItemModel = FoodItemModel(id: "0",food_id: 0, img: "", name: "",calories:0,isFav: false);
    @State var type = "";
    @State var myList  =  [FoodItemModel]()
    
    var body: some View {
        
        ZStack {
            Text("Breakfast").font(.headline).fontWeight(.bold)
            ScrollView(.vertical){
                ZStack{
                    ForEach(0..<myList.count, id: \.self) { index in
                        VStack{
                            FoodCard(food:self.myList[index],loginData:self.loginData)
                        }
                    }
                }
            }
            
            
            
        }.onAppear(){
            self.myList.append(FoodItemModel(id: .init(),food_id: 1, img: "https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466__340.jpg", name: "name1",calories: 900,isFav: false))
            self.myList.append(FoodItemModel(id: .init(),food_id: 1, img: "https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466__340.jpg", name: "name2",calories: 900,isFav: false))
            
        }
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(loginData: LoginData())
    }
}
