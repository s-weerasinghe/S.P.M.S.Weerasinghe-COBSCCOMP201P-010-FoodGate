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
    
    
    func getUser(completionBlock: @escaping (_ success: UserModel) -> Void){
        var db: DatabaseReference!
        db = Database.database().reference()
        guard let id = Auth.auth().currentUser?.uid else {
            completionBlock(UserModel(regid: 0, age: "", name: ""))
            return
        }
        db.child("users").child(id).observeSingleEvent(of: .value, with: { (data) in
            let user = data.value as! [String: Any]
            self.user = UserModel(id: id, regid: user["regid"] as! Int,age: user["age"] as! String,name: user["name"] as! String)
            print ("doneeeeee");
            completionBlock(self.user)
        })
       
    }
    
    
    func getFoodList(type: String,completionBlock: @escaping (_ success: [FoodItemModel]) -> Void) {
      
        var foods:[FoodItemModel] = []
        var db: DatabaseReference!
        db = Database.database().reference()
         let uid = Auth.auth().currentUser?.uid
        db.child(type).queryOrderedByKey().observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                
                let placeDict = snap.value as! [String: Any]
                let img = placeDict["img"] as! String
                let name = placeDict["name"] as! String
                let calories = placeDict["calories"] as! Int
                let id = placeDict["food_id"] as! Int
                let fid = placeDict["id"] as! String
                
               
                let val = placeDict[uid ?? "id"] ?? ""
               
                foods.append(FoodItemModel(id: fid,food_id: id, img: img, name: name,calories:calories,isFav:val as! String=="userFav"))
            }
            completionBlock(foods)
        }
        
    }
    
    func addFav(type: String,food_id:String,user:UserModel){
        print(Auth.auth().currentUser!.uid)
        var db: DatabaseReference!
        db = Database.database().reference()
        db.child(type).child(food_id).child(Auth.auth().currentUser!.uid).setValue("userFav")
        
        
    }
    
    
    func getFoodFavList(type: String,completionBlock: @escaping (_ success: [FoodItemModel]) -> Void) {
      
        var foods:[FoodItemModel] = []
        var db: DatabaseReference!
        db = Database.database().reference()
        
        let uid = Auth.auth().currentUser?.uid
        
        db.child(type).queryOrderedByKey().observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let placeDict = snap.value as! [String: Any]
                let val = placeDict[uid ?? "id"] ?? ""
                if(val as! String=="userFav"){
                    let img = placeDict["img"] as! String
                    let name = placeDict["name"] as! String
                    let calories = placeDict["calories"] as! Int
                    let id = placeDict["food_id"] as! Int
                    let fid = placeDict["id"] as! String
                    foods.append(FoodItemModel(id: fid,food_id: id, img: img, name: name,calories:calories,isFav: true))
                }
            }
            completionBlock(foods)
        }
        
    }

    

    
    func logOut(){
        try! Auth.auth().signOut();
    }
}

