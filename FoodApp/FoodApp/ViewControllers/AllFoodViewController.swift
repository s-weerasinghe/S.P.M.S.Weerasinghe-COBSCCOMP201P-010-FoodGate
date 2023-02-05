//
//  AllFoodViewController.swift
//  FoodApp
//
//  Created by Mobios on 2/5/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import Foundation
import UIKit

class AllFoodViewController : UIViewController {
    
    var foodList : [FoodItemModel] = []
    var controller = ApiController();
    var titleCus = ""
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleCus
        view.backgroundColor = .white
        setupNavigationBar()
        
        setupViews()
        setupConstraints()
        FavouriteTableView.delegate = self
        FavouriteTableView.dataSource = self
        FavouriteTableView.register(FoodViewTableCell.self, forCellReuseIdentifier: FoodViewTableCell.reuseableId)
        
    }
    // hide tabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.layer.zPosition = -1
        
        
        self.foodList = [];
        
        controller.getFoodList(type: type) { (foodListGet) in
            DispatchQueue.main.async {
                self.foodList.append(contentsOf: foodListGet);
                self.FavouriteTableView.reloadData();
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.layer.zPosition = 0
    }
    func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = "Profile"
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
    
    let FavouriteTableView: UITableView = {
        let list = UITableView(frame: .zero)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.showsVerticalScrollIndicator = false
        return list
    }()
    
}

extension AllFoodViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodViewTableCell.reuseableId, for: indexPath) as! FoodViewTableCell
        let item = foodList[indexPath.row]
        cell.setupOrder(for: item)
        cell.retryContainer.isHidden = true
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FoodViewController()
        
        let food = foodList[indexPath.row]
        vc.food = food;
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func setupViews() {
        view.addSubview(FavouriteTableView)
    }
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            FavouriteTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            FavouriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            FavouriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            FavouriteTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}


