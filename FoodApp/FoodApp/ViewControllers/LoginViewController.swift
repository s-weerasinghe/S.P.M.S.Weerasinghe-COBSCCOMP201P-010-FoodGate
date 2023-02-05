//
//  LoginViewController.swift
//  FoodApp
//
//  Created by Mobios on 2/3/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var controller = ApiController();
    
    let firstLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hungry Bird!"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    let greetingLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wellcome back you've been missed"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    let greetingHolder : UIStackView = {
        let holder = UIStackView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.axis = .vertical
        holder.spacing = 15
        holder.alignment = .center
        return holder
        
    }()
    
    let userNameField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter email"
        textField.backgroundColor = .systemGray6
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    let passwordField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "password"
        textField.textContentType = .password
        textField.isSecureTextEntry.toggle()
        textField.backgroundColor = .systemGray6
        return textField
    }()
    
    let recoveryLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recovery password"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .blue
        label.textAlignment = .right
        return label
    }()
    
    let signInButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        return button
    }()
    
    let signUpButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        return button
    }()
    
    let textFieldHolder : UIStackView = {
        let holder = UIStackView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.axis = .vertical
        holder.spacing = 15
        holder.alignment = .center
        return holder
        
    }()
    
    let registerLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Register Now! Click Below"
        return label
    }()

    
    let bottomHolder : UIStackView = {
        let holder = UIStackView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.axis = .vertical
        holder.spacing = 45
        holder.alignment = .center
        return holder
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        greetingHolder.insertArrangedSubview(firstLabel, at: 0)
        greetingHolder.insertArrangedSubview(greetingLabel, at: 1)
        
        textFieldHolder.insertArrangedSubview(userNameField, at: 0)
        textFieldHolder.insertArrangedSubview(passwordField, at: 1)
        textFieldHolder.insertArrangedSubview(recoveryLabel, at: 2)
        textFieldHolder.insertArrangedSubview(signInButton, at: 3)
        
        
        bottomHolder.insertArrangedSubview(registerLabel, at: 0)
        bottomHolder.insertArrangedSubview(signUpButton, at: 1)
        
        
        view.addSubview(greetingHolder)
        view.addSubview(textFieldHolder)
        view.addSubview(bottomHolder)
        setupConstraints()
    }
    
    func setupConstraints() {
        greetingHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        greetingHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70).isActive = true
        greetingHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        
        textFieldHolder.topAnchor.constraint(equalTo: greetingHolder.bottomAnchor, constant: 40).isActive = true
        textFieldHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textFieldHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        userNameField.leadingAnchor.constraint(equalTo: textFieldHolder.leadingAnchor, constant: 20).isActive = true
        userNameField.trailingAnchor.constraint(equalTo: textFieldHolder.trailingAnchor, constant: -20).isActive = true
        userNameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: textFieldHolder.leadingAnchor, constant: 20).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: textFieldHolder.trailingAnchor, constant: -20).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        recoveryLabel.leadingAnchor.constraint(equalTo: textFieldHolder.leadingAnchor, constant: 20).isActive = true
        recoveryLabel.trailingAnchor.constraint(equalTo: textFieldHolder.trailingAnchor, constant: -20).isActive = true
        
        
        signInButton.topAnchor.constraint(equalTo: recoveryLabel.bottomAnchor, constant: 90).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: textFieldHolder.leadingAnchor, constant: 20).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: textFieldHolder.trailingAnchor, constant: -20).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 140).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: textFieldHolder.leadingAnchor, constant: 20).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: textFieldHolder.trailingAnchor, constant: -20).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        bottomHolder.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 40).isActive = true
        bottomHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        bottomHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
    }
    
    
    @objc func loginClick() {
        self.controller.login(email: userNameField.text!, password: passwordField.text!) {(success) in
            if(success){
                self.controller.getUser{(user) -> Void in
                   
                    let home = HomeViewController();
                    home.user = user;
                    let hView = UINavigationController(rootViewController: home)
                    hView.tabBarItem.image = UIImage(systemName: "house")
                    hView.title = "Home"
                    
                    let lView = UINavigationController(rootViewController: ProfileViewController())
                    lView.tabBarItem.image = UIImage(systemName: "person")
                    lView.title = "Profile"
                    
                    let fView = UINavigationController(rootViewController: MyFavouriteViewController())
                    fView.tabBarItem.image = UIImage(systemName: "star")
                    fView.title = "Favourite"
                    
                    self.tabBarController?.tabBar.tintColor = .green
                    self.tabBarController?.viewControllers = [lView,hView,fView];
                    self.tabBarController?.selectedIndex = 0;
                    self.showAlert(title: "Login Success")
                }
            }else{
                self.showAlert(title: "Invalid Email or Password")
            }
        }
        
        
    }
    
    @objc func registerClick() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    func showAlert(title:String){
        let alertView = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
}
