//
//  HomeView.swift
//  FoodApp
//
//  Created by Mobios on 1/22/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var loginData : LoginData
    @State var isLinkActive = false
    var controller = ApiController();
    
     @State var foods:[FoodItemModel]=[]
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .center){
                Text("Email")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                
                
            }.navigationBarTitle("Home", displayMode: .inline)
                .navigationBarItems(trailing:
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
            
            let user = self.controller.getUser() as UserModel;
            print(user)
            
            self.controller.getFoodList(){(success) -> Void in
                self.foods = success;
             print(self.foods)
            }
            print(self.foods)
        }
    }
    

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(loginData: LoginData())
    }
}
