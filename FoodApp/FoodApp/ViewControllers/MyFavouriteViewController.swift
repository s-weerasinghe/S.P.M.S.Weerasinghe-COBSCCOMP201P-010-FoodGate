//
//  MyFavouriteViewController.swift
//  FoodApp
//
//  Created by Mobios on 2/3/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import UIKit

class MyFavouriteViewController: UIViewController {
    
    var foodList : [FoodItemModel] = []
    let controller  = ApiController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        customBackButton()
        FavouriteTableView.delegate = self
        FavouriteTableView.dataSource = self
        FavouriteTableView.register(FoodViewTableCell.self, forCellReuseIdentifier: FoodViewTableCell.reuseableId)
        
    }
    
    func customBackButton(){
        // custom back button
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward",withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward",withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: .none, action: .none)
        navigationController?.navigationBar.tintColor = .black
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        self.foodList = [];
        
        controller.getFoodFavList(type: "breakfast") { (foodListGet) in
            DispatchQueue.main.async {
                self.foodList.append(contentsOf: foodListGet);
                self.FavouriteTableView.reloadData();
            }
        }
        controller.getFoodFavList(type: "lunch") { (foodListGet) in
            DispatchQueue.main.async {
                self.foodList.append(contentsOf: foodListGet);
                self.FavouriteTableView.reloadData();
            }
        }
        controller.getFoodFavList(type: "dinner") { (foodListGet) in
            DispatchQueue.main.async {
                self.foodList.append(contentsOf: foodListGet);
                self.FavouriteTableView.reloadData();
            }
        }
    }
    
    let heading: UILabel = {
        let lb = UILabel()
        lb.text = "My Favourite"
        lb.textColor = color.black
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let FavouriteTableView: UITableView = {
        let list = UITableView(frame: .zero)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.showsVerticalScrollIndicator = false
        return list
    }()
}

extension MyFavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodViewTableCell.reuseableId, for: indexPath) as! FoodViewTableCell
        let item = foodList[indexPath.row]
        cell.setupOrder(for: item)
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
        view.addSubview(heading)
        view.addSubview(FavouriteTableView)
    }
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            heading.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            heading.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            FavouriteTableView.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 10),
            FavouriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            FavouriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            FavouriteTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}
