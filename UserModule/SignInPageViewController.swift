//
//  SignInPageViewController.swift
//  UserModule
//
//  Created by Koushal Sharma on 29/06/17.
//  Copyright © 2017 Koushal Sharma. All rights reserved.
//

import UIKit

class SignInPageViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField! {
        didSet {
            userNameTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    
    var userName: String {
        return userNameTextField.text ?? ""
    }
    var password: String {
        return passwordTextField.text ?? ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if userName.isEmpty ==  true || password.isEmpty == true {
            showAlertViewController(title: "Please Enter All Above Fields", message: nil)
        } else {
            if UserDefaults.standard.value(forKey: userName) != nil {
                guard let userInfo: [String: Any] = UserDefaults.standard.value(forKey: userName) as? [String : Any], let userPassword = userInfo["password"] as? String else { return}
                if password == userPassword {
                    performSegue(withIdentifier: "UserHomePageSegue", sender: nil)
                } else {
                    showAlertViewController(title: "Enter Correct Email-Id Or Password", message: nil)
                }
            } else {
                showAlertViewController(title: "Please Sign Up First", message: nil)
            }
       }
        
    }
}

extension SignInPageViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let emailValidation = validateEmail(userName)
        let passwordValidation = validatePassword(password)
        if textField == userNameTextField {
            if emailValidation == false {
                showAlertViewController(title: "Enter Valid Email Address", message: nil)
            }
        } else if textField == passwordTextField {
            if passwordValidation == false {
               showAlertViewController(title: "Enter Valid Password", message: nil)
            }
        }
    }
}

