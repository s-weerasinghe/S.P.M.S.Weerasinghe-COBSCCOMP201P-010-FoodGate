//
//  ProfileView.swift
//  FoodApp
//
//  Created by Mobios on 1/23/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @Binding var rootView: Bool;
    var controller = ApiController();
    @ObservedObject var loginData : LoginData
     @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack{
            Form {
                Image("nibm_logo")
                    .resizable()
                    .clipped()
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 2.0))
                Section(header: Text("Basic Information")) {
                    HStack {
                        Text("Email")
                        Spacer(minLength: 100)
                        Text(loginData.user.email)
                    }
                    HStack {
                        Text("Name")
                        Spacer(minLength: 100)
                        Text(loginData.user.name)
                    }
                    HStack {
                        Text("Age")
                        Spacer(minLength: 100)
                        Text(loginData.user.age)
                    }
                }
                Section(header: Text("")) {
                    HStack {
                       
                        Button(action:{
                            print("hello");
                            print(self.rootView);
                            self.rootView = false;
                           
                              self.controller.logOut()
                              self.presentationMode.wrappedValue.dismiss()
                            print(self.rootView);
                        }, label:{
                            Text("Logout").fontWeight(.bold)
                                .foregroundColor(Color("primary"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(50.0)
                                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                                .padding(.vertical)
                        })
                    }
                }
                
            }
            
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(loginData: LoginData())
//    }
//}
