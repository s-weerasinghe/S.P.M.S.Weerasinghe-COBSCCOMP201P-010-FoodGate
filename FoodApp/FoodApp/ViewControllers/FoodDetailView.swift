//
//  FoodDetailView.swift
//  FoodApp
//
//  Created by Mobios on 1/22/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import SwiftUI

struct FoodDetailView: View {
    var body: some View {
            NavigationView {
                ZStack {
                    Color("primary").edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                    
                        Spacer()
                        
                        
                        Button(action:{
                                        UIApplication.shared.open(URL(string: "https://www.nibm.lk")!)
                                    }, label:{
                                        Text("Get Started").fontWeight(.regular).padding()
                                    })
                        
                        
//                        NavigationLink(
//                            destination: MyFoodView(),
//                            label: {
//                                Text("Sign In")
//                                    .fontWeight(.bold)
//                                    .foregroundColor(Color("primary"))
//                                    .padding()
//                                    .frame(maxWidth: .infinity)
//                                    .background(Color.white)
//                                    .cornerRadius(50.0)
//                                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
//                                    .padding(.vertical)
//                            })
                        
                        HStack {
                            Text("New around here? ")
                            Text("Sign in")
                                .foregroundColor(Color("primary"))
                        }
                    }
                    .padding()
                }
            }
        }
    }

    struct FoodDetailView_Previews: PreviewProvider {
        static var previews: some View {
            FoodDetailView()
        }
    }
