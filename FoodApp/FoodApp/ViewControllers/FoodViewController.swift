//
//  FoodViewController.swift
//  FoodApp
//
//  Created by Mobios on 2/3/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController {

    var food: FoodItemModel?
    var user : UserModel?
    var type : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
       
       
        view.addSubview(lblHolder)
        view.addSubview(imageHolder)
        view.isUserInteractionEnabled = true
        imageHolder.heightAnchor.constraint(equalToConstant: 280).isActive = true
        imageHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        imageHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        imageHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true

        lblHolder.topAnchor.constraint(equalTo: imageHolder.bottomAnchor, constant: 10).isActive = true
        lblHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        lblHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        
        imageHolder.addArrangedSubview(foodImage);
        foodImage.contentMode = .scaleAspectFit
        foodImage.clipsToBounds=true
        
        
        favHolder.insertArrangedSubview(favButton, at: 0)
        favHolder.insertArrangedSubview(ratingIcon, at: 1)
        
        favHolder.isHidden = user == nil
        
        lblHolder.insertArrangedSubview(foodName, at: 0)
        lblHolder.insertArrangedSubview(foodCal, at: 1)
        lblHolder.insertArrangedSubview(foodIng, at: 2)
        lblHolder.insertArrangedSubview(foodDesc, at: 3)
        lblHolder.insertArrangedSubview(favHolder, at: 4)
        navigationController?.navigationBar.isHidden = false
        
        
        
        foodName.text = food?.name;
        foodDesc.text = food?.description;
        foodIng.text = "Ingredients: \(food?.ingredient as! String)";
        foodCal.text = "Calories: \( food?.calories as! Int)"
        
        foodImage.kf.setImage(with: URL(string: food?.img ?? ""))
        
    }
    
    let favLbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add to Favourite"
        return label
    }()
    let foodName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    
    let foodDesc : UILabel = {
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: 35, height: 45))
        label.text = ""
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    let foodIng : UILabel = {
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: 35, height: 20))
        label.text = ""
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    
    let foodCal : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    
    let lblHolder : UIStackView = {
        let holder = UIStackView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.axis = .vertical
        holder.spacing = 10
        holder.alignment = .center
        holder.isUserInteractionEnabled = true
        return holder
        
    }()
    let imageHolder : UIStackView = {
        let holder = UIStackView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.axis = .vertical
        holder.spacing = 15
        holder.alignment = .center
        return holder
        
    }()
    
    let favHolder : UIStackView = {
        let holder = UIStackView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.axis = .horizontal
        holder.spacing = 5
        return holder
        
    }()
    
    let foodImage : UIImageView = {
        var iv = UIImageView()
        iv.backgroundColor = .black
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let ratingIcon : UIImageView = {
        var iv = UIImageView(frame:.zero)
        let img = UIImage(systemName: "star.fill")
        iv.image = img
        iv.tintColor = .green
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
       
        return iv
    }()
    
    let favButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Favourite" , for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(addFav), for: .touchUpInside)
        return button
    }()
    // hide tabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.layer.zPosition = -1
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.layer.zPosition = 0
    }

    
    func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: color.black]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .black
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        let leftButton = UIBarButtonItem()
        leftButton.customView = backButton
        navigationItem.setLeftBarButton(leftButton, animated: true)
    }
    @objc func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }

    let controller = ApiController();
 
    
    @objc func addFav() {
       
        controller.addFav(type: type, food_id: food!.id, user: user!)
        self.showAlert(title: "Item Added")
    }
    func showAlert(title:String){
        let alertView = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
}
