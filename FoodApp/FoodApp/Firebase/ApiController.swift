//
//  ApiController.swift
//  FoodApp
//
//  Created by Mobios on 1/20/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class ApiController{
    var user = UserModel(regid: 0, age: "", name: "")

    func registerUser(email: String, password: String,name:String,age:String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(res, error) in
            if let user = res?.user {
                let id=Int64((Date().timeIntervalSince1970 * 1000.0).rounded())
                let data    =  ["regid":id,
                                "name":name,
                                "age":age] as [String : Any]
                
                var db: DatabaseReference!
                db = Database.database().reference()
                db.child("users").child(user.uid).setValue(data)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    func login(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func resetPassword(email: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    
    func getUser()->UserModel {
        var db: DatabaseReference!
        db = Database.database().reference()
        guard let id = Auth.auth().currentUser?.uid else {
            return  UserModel(regid: 0, age: "", name: "")
        }
        db.child("users").child(id).observeSingleEvent(of: .value, with: { (data) in
            let user = data.value as! [String: Any]
            self.user = UserModel(id: .init(), regid: user["regid"] as! Int,age: user["age"] as! String,name: user["name"] as! String)
            print ("doneeeeee");
        })
        return self.user;
    }
    
    
    func getFoodList(completionBlock: @escaping (_ success: [FoodItemModel]) -> Void) {
        print ("getFoodList");
        var foods:[FoodItemModel] = []
        var db: DatabaseReference!
        db = Database.database().reference()
        db.child("foods").queryOrderedByKey().observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                
                let placeDict = snap.value as! [String: Any]
                let img = placeDict["img"] as! String
                let name = placeDict["name"] as! String
                let id = placeDict["food_id"] as! Int
                foods.append(FoodItemModel(id: .init(),food_id: id, img: img, name: name))
            }
            completionBlock(foods)
        }
         
    }
    

    
    func logOut(){
        try! Auth.auth().signOut();
    }
}

