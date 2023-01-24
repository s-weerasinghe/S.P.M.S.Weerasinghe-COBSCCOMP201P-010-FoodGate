//
//  ProfileView.swift
//  FoodApp
//
//  Created by Mobios on 1/23/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            VStack(alignment: .center){
         
                
VStack (alignment: .leading, spacing: 16) {
//    SectionTitleView(title: "Today's Fresh Recipes")
    
    ScrollView (.horizontal, showsIndicators: false) {
        HStack (spacing: 16) {
            
            RecipeCard(image: "star")
//            RecipeCard(image: #imageLiteral(resourceName: "nibm_logo"))
        }
    }
}
                
                Button(action:{
                    UIApplication.shared.open(URL(string: "https://www.nibm.lk")!)
                }, label:{
                    Text("Terms & Conditions").fontWeight(.regular).padding()
                })
            }.padding(10.0)
                .onAppear {
                    
            }
            
        }
        
    }
}

struct RecipeCard: View {
    let image: String
    var body: some View {
        ZStack {
            VStack (alignment: .leading, spacing: 8) {
                Image(systemName: "star")
                    .padding(.bottom, 60)
                Text("Breakfast")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                Text("French Toast with Berries")
                    .fontWeight(.medium)
                    .lineLimit(nil)
                HStack (spacing: 2) {
                    ForEach(0 ..< 5) { item in
                        Image(systemName: "star")
                            .renderingMode(.template)
                            .foregroundColor(Color("primary"))
                    }
                }
                Text("120 Calories")
                    .font(.caption)
                    .foregroundColor(Color("primary"))
                
                HStack {
                    Image(systemName: "star")
                    Text("10 mins")
                        .font(.title)
                        .foregroundColor(Color.gray)
                    Spacer()
                    
                    Image(systemName: "star")
                    Text("1 Serving")
                        .font(.title)
                        .foregroundColor(Color.gray)
                }
                
            }
            .frame(width: 147)
            .padding()
            .background(Color.gray)
            .cornerRadius(20.0)
            
            //                Image
            Image(systemName: image)
                .offset(x: 45, y: -60)
            
        }
        .padding(.trailing, 25)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
