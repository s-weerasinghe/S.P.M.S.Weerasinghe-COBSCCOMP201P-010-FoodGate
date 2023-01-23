//
//  RegisterView.swift
//  FoodApp
//
//  Created by Mobios on 1/20/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    
    
    @State var name = "";
    @State var email = "";
    @State var password = "";
    @State var age = "";
    
    @State private var alert: CustomAlert?;
    var controller = ApiController();
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
           Color("background").edgesIgnoringSafeArea(.all)
        
                ScrollView(.vertical){
                    VStack(alignment: .center){
                        
                        VStack{
                            Text("Email").font(.title)
                            TextField("",text: self.$email).keyboardType(.emailAddress).autocapitalization(.none).frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
                            
                            Text("Password").font(.title)
                            SecureField("",text: self.$password)
                                .frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
                        }.padding(.top, 20.0)
                        
                        Text("Name").font(.title)
                        TextField("",text: self.$name)
                            .frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
                        
                        Text("Age").font(.title)
                        TextField("",text: self.$age)
                            .frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
                        
                        VStack{
                            
                            Button(action:{
                                
                                if(self.email.isEmpty){
                                    self.alert = CustomAlert(msg: "Please Enter Email");
                                    return;
                                }
                                if(!self.checkValidEmail(self.email)){
                                    self.alert = CustomAlert(msg: "Invalid Email");
                                    return;
                                }
                                if(self.password.isEmpty){
                                    self.alert = CustomAlert(msg: "Please Enter Password");
                                    return;
                                }
                                if(!self.checkValidPassword(self.password)){
                                    self.alert = CustomAlert(msg: "Password at least 8 characters");
                                    return;
                                }
                                
                                
                                self.controller.registerUser(email: self.email, password: self.password, name: self.name, age: self.age) {(success) in
                                    if(success){
                                        self.alert = CustomAlert(msg: "Success");
                                        self.presentationMode.wrappedValue.dismiss()
                                    }else{
                                        self.alert = CustomAlert(msg: "Failed");
                                    }
                                }
                            }, label:{
                                Text("Sign Up").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 220.0, height: 50.0).background(Color("primary")).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                            }).alert(item: self.$alert) { con in
                                Alert(title: Text(con.msg))
                            }.padding(.top, 5.0)
                            
                            Button(action:{
                                //action
                            }, label:{
                                Text("Login").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 150.0, height: 40.0).background(Color("secondary")).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                            })
                                .padding(.top, 20.0)
                        }
                        
                    }
                
            }.onAppear {
                //view load event
            }
        }
    }
    
    
    
    
    func checkValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    func checkValidPassword(_ password: String) -> Bool {
        if  8 > password.trimmingCharacters(in: CharacterSet.whitespaces).count {
            return false
        }else{
            return true;
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
