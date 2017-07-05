//
//  SignInPageViewController.swift
//  UserModule
//
//  Created by Koushal Sharma on 29/06/17.
//  Copyright © 2017 Koushal Sharma. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
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
        
        hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if userName.isEmpty ==  true || password.isEmpty == true {
            showAlertViewController(alert: .fillAllTheFieldsFirst)
        } else {
            if UserDefaults.standard.value(forKey: userName) != nil {
                guard let userInfo: [String: Any] = UserDefaults.standard.value(forKey: userName) as? [String : Any], let userPassword = userInfo[UserDetail.password] as? String else { return}
                if password == userPassword {
                   self.performSegue(identifier: .signInToUserDetail)
                    
                } else {
                    showAlertViewController(alert: .emailOrPasswordNotCorrect)
                }
            } else {
                showAlertViewController(alert: .signUpFirst)
            }
       }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.signInToUserDetail.identifier {
            let userDetailViewControoler = segue.destination as! UserDetailViewController
            userDetailViewControoler.emailId = userName
        }
    }
}
extension SignInViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let emailValidation = Validation.validateEmail(userName)
        let passwordValidation = Validation.validatePassword(password)
        if textField == userNameTextField {
            if emailValidation == false {
                showAlertViewController(alert: .emailNotValid)
            }
        } else if textField == passwordTextField {
            if passwordValidation == false {
                showAlertViewController(alert: .passwordNotValid)
            }
        }
    }
}

