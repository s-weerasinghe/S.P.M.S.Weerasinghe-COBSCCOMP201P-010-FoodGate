//
//  MainViewController.swift
//  FoodApp
//
//  Created by Mobios on 2/3/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    var controller = ApiController();
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.controller.getUser{(user) -> Void in
            print(user)
            
            if(user.regid==0){
                self.createView(isLogin:false)
            }else{
                self.createView(isLogin:true)
            }
            
        }
        
    }
    
    func createView(isLogin:Bool){
        let hView = UINavigationController(rootViewController: HomeViewController())
        hView.tabBarItem.image = UIImage(systemName: "house")
        hView.title = "Home"
        
        let lView = UINavigationController(rootViewController: ProfileViewController())
        lView.tabBarItem.image = UIImage(systemName: "person")
        lView.title = "Profile"
        
        let fView = UINavigationController(rootViewController: MyFavouriteViewController())
        fView.tabBarItem.image = UIImage(systemName: "star")
        fView.title = "Favourite"
        
        if(isLogin){
            tabBar.tintColor = .green
            
            setViewControllers([lView,hView,fView], animated: true)
            
        }else{
            let loginview = UINavigationController(rootViewController: LoginViewController())
            loginview.tabBarItem.image = UIImage(systemName: "person")
            loginview.title = "Login"
            
            tabBar.tintColor = .red
            setViewControllers([hView,loginview], animated: true)
        }
        
    }
}
