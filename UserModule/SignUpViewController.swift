//
//  SignUpViewController.swift
//  UserModule
//
//  Created by Koushal Sharma on 29/06/17.
//  Copyright © 2017 Koushal Sharma. All rights reserved.
//

import UIKit

enum SignUpAlertType {
    case passwordNotMatch
    case passwordNotValid
    case alreadySignedUp
    case successfullySignedUp
    case fillAllTheFieldsFirst
    case emailNotValid
    
    
    var title: String {
        switch self {
        case .passwordNotMatch:
            return "Password "
        case .passwordNotValid:
            return "Invalid"
        case .alreadySignedUp:
            return "You Already Signed Up"
        case .successfullySignedUp:
            return "Successfully Signed Up"
        case .fillAllTheFieldsFirst:
            return "First Fill All The Fields"
        case .emailNotValid:
            return "Email Id is not valid"
        }
    }
    
    var message: String? {
        switch self {
        case .passwordNotMatch:
            return "Password and Confirm Password are not same"
        case .passwordNotValid:
            return "Password should be minimum of 8 and maxinmum of 32 character having 1 special, cap, num character"
        case .alreadySignedUp:
            return nil
        case .successfullySignedUp:
            return "Now you can login from home page"
        case .fillAllTheFieldsFirst:
            return "All fields are mandatory to fill"
        case .emailNotValid:
            return nil
            
        }
    }
}

class SignUpViewController: UIViewController {
    
    var passwordValidationFlag = false
    var emailValidationFlag = false
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet{
            firstNameTextField.delegate = self
        }
    }
    @IBOutlet weak var lastNameTextField: UITextField! {
        didSet{
            lastNameTextField.delegate = self
        }
    }
    @IBOutlet weak var emailIdTextField: UITextField! {
        didSet{
            emailIdTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    @IBOutlet weak var confirmPasswordTextField: UITextField! {
        didSet {
            confirmPasswordTextField.isEnabled = false
            confirmPasswordTextField.delegate = self
        }
    }
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.isEnabled = false
        }
    }
    
    var firstName: String {
        return firstNameTextField.text ?? ""
    }
    var lastName: String {
        return lastNameTextField.text ?? ""
    }
    var emailId: String {
        return emailIdTextField.text ?? ""
    }
    var password: String {
        return passwordTextField.text ?? ""
    }
    var confirmPassword: String {
        return confirmPasswordTextField.text ?? ""
    }
    var firstPageAfterSignUpSegue: String = "FirstPageAfterSignUp"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        if (firstName.isEmpty == true || lastName.isEmpty == true || emailId.isEmpty == true || password.isEmpty == true || confirmPassword.isEmpty == true) {
            showAlertViewController(alert: .fillAllTheFieldsFirst)
        } else {
            let userInfo: [String: Any] = ["firstName": firstName,
                                           "lastName": lastName,
                                           "password": password,
                                           ]
            if UserDefaults.standard.value(forKey: emailId) != nil {
                showAlertViewController(alert: .alreadySignedUp)
            } else {
                let alertController = UIAlertController(title: "You are successfully Signed Up", message: nil, preferredStyle: .alert )
                let okay = UIAlertAction(title: "Okay", style: .cancel) { _ in
                    UserDefaults.standard.set(userInfo, forKey: self.emailId)
                    self.performSegue(withIdentifier: self.firstPageAfterSignUpSegue, sender: nil)
                }
                alertController.addAction(okay)
                present(alertController, animated: true, completion: nil )
            }
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let emailValidation = validateEmail(emailId)
        if textField == emailIdTextField, emailValidation == false, emailId.count >= 1 {
                alertIndicatorOnTextField(textField: emailIdTextField)
            showAlertViewController(alert: .emailNotValid)
            } else if emailValidation == true {
                emailValidationFlag = true
                emailIdTextField.rightViewMode = .never
            }
        if textField == passwordTextField {
            let passwordValidation = validatePassword(password)
            if passwordValidation  == false {
                showAlertViewController(alert: .passwordNotValid)
            } else {
                confirmPasswordTextField.isEnabled = true
                passwordValidationFlag = true
            }
        }
        if textField == confirmPasswordTextField, password != confirmPassword, confirmPassword.count >= 1 {
            showAlertViewController(alert: .passwordNotMatch)
                alertIndicatorOnTextField(textField: passwordTextField)
            }
        if passwordTextField.text == confirmPassword, passwordValidationFlag == true, emailValidationFlag == true, firstName.isEmpty == false, lastName.isEmpty == false {
            signUpButton.isEnabled = true
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
