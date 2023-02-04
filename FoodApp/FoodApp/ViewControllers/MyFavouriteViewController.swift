//
//  MyFavouriteViewController.swift
//  FoodApp
//
//  Created by Mobios on 2/3/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import UIKit

class MyFavouriteViewController: UIViewController {
    
    let foodList : [FoodItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.register(FoodViewTableCell.self, forCellReuseIdentifier: FoodViewTableCell.reuseableId)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    let heading: UILabel = {
        let lb = UILabel()
        lb.text = "My Favourite"
        lb.textColor = color.black
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let orderTableView: UITableView = {
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
        return 133.0
    }
    
    
    func setupViews() {
        view.addSubview(heading)
        view.addSubview(orderTableView)
    }
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            heading.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            heading.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            orderTableView.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 10),
            orderTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            orderTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            orderTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}
