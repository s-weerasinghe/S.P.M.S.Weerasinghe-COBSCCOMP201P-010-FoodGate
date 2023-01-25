//
//  ProfileTextFieldView.swift
//  FoodApp
//
//  Created by Mobios on 1/23/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import Foundation
import SwiftUI

struct SectionTitleView: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("See All")
                .foregroundColor(Color("primary"))
                .onTapGesture {
                    
                }
        }
    }
}
