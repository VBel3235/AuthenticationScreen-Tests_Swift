//
//  ViewController.swift
//  M11LoginPasswordProjectPlusTests
//
//  Created by Владислав Белов on 10.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let emailTextField = VBTextField(placeholderText: "Email")
    
    let passwordTextField = VBTextField(placeholderText: "Password")
    
    let checkButton = VBButton()
    
    let userDatabase: [Users] = [Users(email: "user1@gmail.com", password: "User11234"),
                                 Users(email: "user2@gmail.com", password: "User21234"),
                                 Users(email: "user3@gmail.com", password: "User31234"),
                                 Users(email: "user4@gmail.com", password: "User41234"),
                                ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        configureLoginTextfield()
        configurePasswordTextField()
        configureCheckButton()
        createTapGestureToReturn()
        checkButton.isEnabled = false
        checkButton.alpha = 0.5
        // Do any additional setup after loading the view.
    }
    
    func createTapGestureToReturn(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    func configureLoginTextfield(){
        view.addSubview(emailTextField)
        emailTextField.delegate = self
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.widthAnchor.constraint(equalToConstant: 300)
            
        
        ])
    }
    
    func configurePasswordTextField(){
        view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 6),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func configureCheckButton(){
        view.addSubview(checkButton)
        checkButton.addTarget(self, action: #selector(checkEmailAndPassword), for: .touchUpInside)
        NSLayoutConstraint.activate([
            checkButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            checkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            checkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            checkButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func showPopUpMessage(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true, completion: nil)
    }
    
    @objc func checkEmailAndPassword() -> String{
        var result = String()
        print("start")
        for i in userDatabase{
            if emailTextField.text == i.email && passwordTextField.text!.isValidPassword == true && passwordTextField.text! == i.password{
                   result = "Success"
                showPopUpMessage(title: result, message: "Email and Password are correct!")
                return result
            }
            
        }
        result = "Error"
        showPopUpMessage(title: result, message: "Email or Password are incorrect. Try again :(")
        return "result"
    }


}

extension String {
    var isValidPassword: Bool {
        //Regex restricts to 6 character minimum, 1 capital letter, 1 lowercase letter, 1 number
        //If you have different requirements a google search for "password requirement regex" will help
        let passwordFormat      = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}"
        let passwordPredicate   = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0{
            checkEmailAndPassword()
        } else {
            showPopUpMessage(title: "Error", message: "Enter email and password first")
        }
       
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0{
            checkButton.isEnabled = true
            checkButton.alpha = 1
        } else {
            checkButton.isEnabled = false
            checkButton.alpha = 0.5
        }
    }
}
