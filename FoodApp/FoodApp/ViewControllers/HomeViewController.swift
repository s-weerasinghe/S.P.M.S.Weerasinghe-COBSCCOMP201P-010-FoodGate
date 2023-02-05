//
//  HomeViewController.swift
//  FoodApp
//
//  Created by Mobios on 2/3/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {


    let controller = ApiController();
    var foodListB:[FoodItemModel]=[ ]
    var foodListL:[FoodItemModel]=[ ]
    var foodListD:[FoodItemModel]=[ ]
    let reusableId = "cellId"
    let foodLayout = FoodLayout.shared
    var user : UserModel? = nil
    
    var myCollectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        setupViews()
        setupConstraints()
        customBackButton()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FoodCollectionViewCell.self, forCellWithReuseIdentifier: FoodCollectionViewCell.reusableId)

        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: HeaderView.reusableId, withReuseIdentifier: HeaderView.reusableId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reusableId)
        
        
        controller.getFoodList(type: "breakfast") { (foodListGet) in
            DispatchQueue.main.async {
            self.foodListB = foodListGet;
                self.collectionView.reloadData();
            }
        }
        controller.getFoodList(type: "lunch") { (foodListGet) in
            DispatchQueue.main.async {
            self.foodListL = foodListGet;
                self.collectionView.reloadData();
            }
        }
        
        controller.getFoodList(type: "dinner") { (foodListGet) in
            DispatchQueue.main.async {
            self.foodListD = foodListGet;
                self.collectionView.reloadData();
            }
        }


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("asdadad")
        controller.getFoodList(type: "breakfast") { (foodListGet) in
            DispatchQueue.main.async {
            self.foodListB = foodListGet;
                self.collectionView.reloadData();
            }
        }
        controller.getFoodList(type: "lunch") { (foodListGet) in
            DispatchQueue.main.async {
            self.foodListL = foodListGet;
                self.collectionView.reloadData();
            }
        }
        
        controller.getFoodList(type: "dinner") { (foodListGet) in
            DispatchQueue.main.async {
            self.foodListD = foodListGet;
                self.collectionView.reloadData();
            }
        }
    }

    
    func customBackButton(){
        // custom back button
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward",withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward",withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: .none, action: .none)
        navigationController?.navigationBar.tintColor = .black
    }
    
    // MARK: Properties -
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    
    func setupViews(){
        view.addSubview(container)
        container.addSubview(collectionView)
        setupCompositionalLayout()
    }
    func setupCompositionalLayout(){
        let layout = UICollectionViewCompositionalLayout { sectionNumber, env in

            return self.foodLayout.foodLayout()

        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    func setupConstraints(){
        container.pin(to: view)
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: container.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
        ])
    }

    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return foodListB.count
        }else if(section == 1){
            return foodListL.count
        }else if(section == 2){
            return foodListD.count
        }
        return Int()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCollectionViewCell.reusableId, for: indexPath) as! FoodCollectionViewCell
            cell.data = foodListB[indexPath.row]
            return cell
        }else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCollectionViewCell.reusableId, for: indexPath) as! FoodCollectionViewCell
            cell.data = foodListL[indexPath.row]
            return cell
        }else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCollectionViewCell.reusableId, for: indexPath) as! FoodCollectionViewCell
            cell.data = foodListD[indexPath.row]
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId, for: indexPath)
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reusableId, for: indexPath) as! HeaderView
        if indexPath.section == 0 {
            view.headingLabel.text = "Breakfast"
        }else if indexPath.section == 1 {
            view.headingLabel.text = "Lunch"
        }else if indexPath.section == 2 {
            view.headingLabel.text = "Dinner"
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FoodViewController()
        if indexPath.section == 0{
            let food = foodListB[indexPath.row]
            vc.food = food;
            vc.type = "breakfast"
            vc.user = user
        }else  if indexPath.section == 1{
            let food = foodListL[indexPath.row]
            vc.food = food;
            vc.type = "lunch"
            vc.user = user
        }else  if indexPath.section == 2{
            let food = foodListD[indexPath.row]
            vc.food = food;
            vc.type = "dinner"
            vc.user = user
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}




extension UIView {
    
    func pin(to superview: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func addBottomShadows(){
        layer.shadowColor = color.grey.cgColor
        layer.shadowRadius = 3
        layer.masksToBounds  = false
        layer.shadowOffset =  CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.6
        backgroundColor = .white
        layer.shadowPath = CGPath(rect: CGRect(x: 0,y: bounds.maxY - layer.shadowRadius,width: bounds.width,height: layer.shadowRadius), transform: .none)
    }
    func removeBottomShadows(){
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset =  CGSize(width: 0, height: 3)
        layer.shadowRadius = 0
        layer.masksToBounds  = false
        layer.shadowOpacity = 0
        layer.shadowPath = nil
    }
}
