//
//  HomeView.swift
//  FoodApp
//
//  Created by Mobios on 1/22/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var rootView = false;
    var controller = ApiController();
    @ObservedObject var loginData : LoginData
    @State var isLinkActive = false
    
    @State private var alert: CustomAlert?;
    
    @State var breakfast:[FoodItemModel]=[ FoodItemModel(id: .init(),food_id: 1, img: "https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466__340.jpg", name: "name",calories: 900,isFav: false,description: "")]
    
    @State var dinner:[FoodItemModel]=[ FoodItemModel(id: .init(),food_id: 1, img: "https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466__340.jpg", name: "name",calories: 900,isFav: false,description: "")]
    
    @State var lunch:[FoodItemModel]=[ FoodItemModel(id: .init(),food_id: 1, img: "https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466__340.jpg", name: "name",calories: 900,isFav: false,description: "")]
    
    
    //    @State var foods: [FoodItemModel]=[]
    
    var body: some View {
        
        NavigationView {
            ZStack{
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
                                    destination: MyFoodView(loginData: loginData,viewOnly: true),
                                    label: {
                                        Image(systemName: "star").imageScale(.large).foregroundColor(Color("primary"))
                                })
                            }
                        }
                        , trailing:
                        HStack {
                            if(loginData.loginState){
                                NavigationLink(
                                    destination: ProfileView(rootView: $rootView, loginData:loginData),
                                    isActive: $rootView,
                                    label: {
                                        Image(systemName: "person")
                                            .imageScale(.large)
                                            .foregroundColor(Color("primary"))
                                })
                                
                                //                                Button(action:{
                                //                                    self.rootView=true;
                                //                                print(self.rootView);
                                //                                }, label:{
                                //                                    Image(systemName: "person")
                                //                                        .imageScale(.large)
                                //                                        .foregroundColor(Color.purple)
                                //                                })
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
            NavigationLink(
                destination: ProfileView(rootView: $rootView, loginData:loginData),
                isActive: $rootView,
                label: {
                    Text("");
            })
        }
    }
}

struct FoodCard: View {
    @State var food :FoodItemModel;
    @State var loginData : LoginData;
    @State var selectedColor = "primary"
    @State var type = ""
    @State var showFooter = true
    @State var showFoodView = false
    @State var cardH:CGFloat = 250
    
    var body: some View {
        
        VStack{
            //            Image("food").resizable()
            //                .aspectRatio(contentMode: .fit)
            //                .frame(width:220, height:150).padding(1).frame(idealHeight: UIScreen.main.bounds.width / 2 * 3)
            
            //            NavigationLink(
            //                destination: FoodDetailView(loginData: loginData,food:food).onAppear {
            //                    self.selectedColor = "selected"
            //                },
            //                label: {
            AsyncImage(urlString: food.img)
            //            })
            
            Text(food.name).foregroundColor(.black)
            
            Text("\(food.calories) Calories")
                .font(.caption)
                .foregroundColor(Color.black)
            
            if(showFooter){
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
                        
                    }
                    Spacer()
                    NavigationLink(
                        destination: FoodDetailView(loginData: loginData,food:food).onAppear {
                            
                        },
                        label: {
                            Image(systemName: "eye").foregroundColor(Color.white)
                            
                    })
                    
                }
                .padding(5.0)
            }
        }
        .frame(width: 250,height: cardH)
        .background(Color(hue: 0.566, saturation: 0.0, brightness: 0.91))
        .padding(1.0)
        .cornerRadius(15)
        
        
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(rootView: false, loginData: LoginData())
//    }
//}
