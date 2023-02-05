//
//  RegisterViewController.swift
//  FoodApp
//
//  Created by Mobios on 2/3/23.
//  Copyright © 2023 Sweerasinghe. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var controller = ApiController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        view.backgroundColor = .white
        setupNavigationBar()
        setupViews()
        setupConstraints()
        [firstnameInput,passwordInput,emailInput,ageInput,phoneInput].forEach {
            $0.delegate = self
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    // hide tabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
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
    // MARK: Properties -
    let firstnameInput: UITextField = {
        let input =  BFTextField(frame: .zero)
        input.placeholder = "Name"
        input.title = "Name"
        input.text = ""
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    let passwordInput: UITextField = {
        let input =  BFTextField(frame: .zero)
        input.placeholder = "Password"
        input.title = "Password"
        input.text = ""
        input.isSecureTextEntry.toggle()
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    let emailInput: UITextField = {
        let input =  BFTextField(frame: .zero)
        input.placeholder = "E-mail"
        input.title = "E-mail"
        input.text = ""
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    let ageInput: UITextField = {
        let input =  BFTextField(frame: .zero)
        input.placeholder = "Age"
        input.title = "Age"
        input.text = ""
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    let phoneInput: UITextField = {
        let input =  BFTextField(frame: .zero)
        input.placeholder = "Phone number"
        input.title = "Phone number"
        input.text = ""
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    let inputStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10.0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let signUpBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("Register", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.backgroundColor = color.red
        btn.layer.cornerRadius = 54/2
        btn.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func registerClick(){
        if(self.emailInput.text!.isEmpty){
            showAlert(title: "Please Enter Email")
            return;
        }

        if(!self.checkValidEmail(self.emailInput.text!)){
            showAlert(title: "Invalid Email")
            return;

        }
        if(self.passwordInput.text!.isEmpty){
            showAlert(title: "Please Enter Password")
            return;
        }
        if(!self.checkValidPassword(self.passwordInput.text!)){
            showAlert(title: "Password at least 6 characters")
            return;
        }

        self.controller.registerUser(email: emailInput.text!, password: passwordInput.text!, name: firstnameInput.text!, age: ageInput.text!, phone: phoneInput.text!) {(success) in
            if(success){
                self.showAlert(title: "Success")
            }else{
                self.showAlert(title: "Failed")
            }
        }
    }
    
    @objc func hideKeyboard(){
        [firstnameInput,passwordInput,emailInput,ageInput].forEach { item in
            item.resignFirstResponder()
            item.removeBorders()
        }
    }
    func setupViews(){
        [inputStack,signUpBtn].forEach {
            view.addSubview($0)
        }
        [firstnameInput,passwordInput,emailInput,ageInput,phoneInput].forEach {
            inputStack.addArrangedSubview($0)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if firstnameInput.isFirstResponder{
            firstnameInput.addBorders()
            [emailInput,passwordInput].forEach {
                $0.removeBorders()
            }
        }
        else if passwordInput.isFirstResponder {
            passwordInput.addBorders()
            [firstnameInput,emailInput].forEach {
                $0.removeBorders()
            }
        }
        else if emailInput.isFirstResponder{
            emailInput.addBorders()
            [firstnameInput,passwordInput].forEach {
                $0.removeBorders()
            }
        }
        else if ageInput.isFirstResponder{
            ageInput.addBorders()
            [passwordInput,emailInput].forEach {
                $0.removeBorders()
            }
        }
        else if phoneInput.isFirstResponder{
            phoneInput.addBorders()
            [ageInput,emailInput].forEach {
                $0.removeBorders()
            }
        }
    }
    func removeResponder(input: UITextField){
        if firstnameInput.isFirstResponder{
            removeResponder(input: firstnameInput)
            input.resignFirstResponder()
        }
        else if passwordInput.isFirstResponder{
            removeResponder(input: passwordInput)
            input.resignFirstResponder()
        }
        else if emailInput.isFirstResponder{
            removeResponder(input: emailInput)
            input.resignFirstResponder()
        }
        else if phoneInput.isFirstResponder{
            removeResponder(input: phoneInput)
            input.resignFirstResponder()
        }
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            inputStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            inputStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            inputStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            firstnameInput.heightAnchor.constraint(equalToConstant: 60),
            emailInput.heightAnchor.constraint(equalToConstant: 60),
            passwordInput.heightAnchor.constraint(equalToConstant: 60),
            ageInput.heightAnchor.constraint(equalToConstant: 60),
            phoneInput.heightAnchor.constraint(equalToConstant: 60),
            
            signUpBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signUpBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signUpBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signUpBtn.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    func showAlert(title:String){
        let alertView = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){_ in
            if(title=="Success"){
                self.navigationController?.popViewController(animated: true)
            }
        }
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func checkValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    func checkValidPassword(_ password: String) -> Bool {
        if  8 > password.trimmingCharacters(in: CharacterSet.whitespaces).count {
            return false
        }else{
            return true;
        }
    }
    
}
