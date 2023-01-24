//
//  LoginView.swift
//  FoodApp
//
//  Created by Mobios on 1/20/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var loginData : LoginData
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isPushed = false
    @State var email = "";
    @State var password = "" ;
    
    @State private var alert: CustomAlert?;
    var controller = ApiController();
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center){
                Text("Email")
                    .font(.title)
                    .multilineTextAlignment(.center)
                TextField("",text: $email).keyboardType(.emailAddress).autocapitalization(.none)
                    .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground)).accessibility(identifier: "email_txt")
                
                Text("Password")
                    .font(.title)
                    .padding(.top, 10.0)
                SecureField("",text: $password)
                    .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground)).accessibility(identifier: "password_txt")
                
                Button(action:{
                    self.controller.login(email: self.email, password: self.password) {(success) in
                        
                        if(success){
                            self.loginData.loginState = true;
                            self.isPushed = true;
//                            self.presentationMode.wrappedValue.dismiss()
                            
                        }else{
                            self.alert = CustomAlert(msg: "Invalid Email or Password");
                        }
                    }
                    
                }, label:{
                    Text("Sign In").fontWeight(.bold)
                    .foregroundColor(Color("primary"))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(50.0)
                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                    .padding(.vertical)
                }).accessibility(identifier: "login_btn").alert(item: $alert) { con in
                    Alert(title: Text(con.msg))
                }.padding(.top, 20.0)
                
                NavigationLink(
                    destination: RegisterView(),
                    label: {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(Color("primary"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                            .padding(.vertical)
                }).navigationBarTitle("Login")
                
                
                
                Spacer()
                
                Button(action:{
                    //action
//                    self.isPushed = true;
                }, label:{
                    Text("Forget Password").fontWeight(.semibold).padding()
                })
                
                Button(action:{
                    UIApplication.shared.open(URL(string: "https://www.nibm.lk")!)
                }, label:{
                    Text("Terms & Conditions").fontWeight(.regular).padding()
                })
                }.padding(10.0)
            .onAppear {
                
            }
            NavigationLink(destination: HomeView(loginData: loginData), isActive: $isPushed, label: {
                Text("")
            }).navigationBarTitle("Login")
        }
        
        
        
    }
    
}




struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginData: LoginData())
    }
}
