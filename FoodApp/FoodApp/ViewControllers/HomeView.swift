//
//  HomeView.swift
//  FoodApp
//
//  Created by Mobios on 1/22/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var controller = ApiController();
    @ObservedObject var loginData : LoginData
    @State var isLinkActive = false
    
    @State private var alert: CustomAlert?;
    
    @State var breakfast:[FoodItemModel]=[ FoodItemModel(id: .init(),food_id: 1, img: "https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466__340.jpg", name: "name",calories: 900,isFav: false)]
    
    @State var dinner:[FoodItemModel]=[ FoodItemModel(id: .init(),food_id: 1, img: "https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466__340.jpg", name: "name",calories: 900,isFav: false)]
    
    @State var lunch:[FoodItemModel]=[ FoodItemModel(id: .init(),food_id: 1, img: "https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466__340.jpg", name: "name",calories: 900,isFav: false)]
    
    
    //    @State var foods: [FoodItemModel]=[]
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical){
                VStack(){
                    Text("Breakfast").font(.headline).fontWeight(.bold)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(self.breakfast, id: \.id) { result in
                                FoodCard(food:result,loginData:self.loginData,type:"breakfast")
                            }
                        }
                    }
                    Text("Lunch").font(.headline).fontWeight(.bold)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(self.lunch, id: \.id) { result in
                                FoodCard(food:result,loginData:self.loginData,type:"lunch")
                            }
                        }
                    }
                    Text("Dinner").font(.headline).fontWeight(.bold)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(self.dinner, id: \.id) { result in
                                FoodCard(food:result,loginData:self.loginData,type:"dinner")
                            }
                        }
                    }
                }.padding(10)
            }.navigationBarTitle("Home", displayMode: .inline)
                .navigationBarItems(leading:
                    HStack {
                        if(loginData.loginState){
                            NavigationLink(
                                destination: MyFoodView(loginData: loginData),
                                label: {
                                    Image(systemName: "star").imageScale(.large).foregroundColor(Color("primary"))
                            })
                        }
                    }
                    , trailing:
                    HStack {
                        if(loginData.loginState){
                            NavigationLink(
                                destination: ProfileView(),
                                label: {
                                    Image(systemName: "person")
                                        .imageScale(.large)
                                        .foregroundColor(Color("primary"))
                            })
                        }else{
                            NavigationLink(
                                destination: LoginView(loginData: loginData),
                                label: {
                                    Image(systemName: "person").imageScale(.large)
                            })
                        }
                    }
            )
        }.onAppear(){
            
            self.controller.getUser{(user) -> Void in
                print(user)
                self.loginData.loginState = !(user.regid==0);
                self.loginData.user = user;
                
                self.controller.getFoodList(type:"breakfast"){(success) -> Void in
                    self.breakfast = success;
                }
                
                self.controller.getFoodList(type:"dinner"){(success) -> Void in
                    self.dinner = success;
                }
                
                self.controller.getFoodList(type:"lunch"){(success) -> Void in
                    self.lunch = success;
                }
                
            };
            
            
            
            
        }
    }
    
    
}

struct FoodCard: View {
    @State var food :FoodItemModel;
    @State var loginData : LoginData;
    @State var selectedColor = "primary"
     @State var type = ""

    var body: some View {
        
        VStack{
            //            Image("food").resizable()
            //                .aspectRatio(contentMode: .fit)
            //                .frame(width:220, height:150).padding(1).frame(idealHeight: UIScreen.main.bounds.width / 2 * 3)
            AsyncImage(urlString: food.img)
           
            Text(food.name).foregroundColor(.black)
            
            Text("\(food.calories) Calories")
                .font(.caption)
                .foregroundColor(Color.black)
            HStack {
                if(!loginData.loginState){
                    NavigationLink(
                        destination: LoginView(loginData: loginData),
                        label: {
                            Image(systemName: "star").foregroundColor(Color("primary"))
                                
                    })
                }else{
                    NavigationLink(
                        destination: MyFoodView(loginData: loginData,food:food,type:type).onAppear {
                           self.selectedColor = "selected"
                        },
                        label: {
//                            let s = (self.food.isFav ? "" : "")
                            Image(systemName: "star").foregroundColor(Color(food.isFav ? "selected" : selectedColor ))

                    })
//                    Button(action: {
//                        print("button pressed")
//                        print(self.food.img)
//
//                        self.loginData.reloadUI = true;
//
//                    }) {
//                        Image(systemName: "star")
//                            .foregroundColor(Color(selectedColor))
//                    }
                    
                }
                Spacer()
                Image(systemName: "eye").foregroundColor(Color.white)
                
              
            }
            .padding(5.0)
        }
        .frame(width: 250,height: 250)
        .background(Color(hue: 0.566, saturation: 0.0, brightness: 0.91))
        .padding(1.0)
        .cornerRadius(15)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(loginData: LoginData())
    }
}
