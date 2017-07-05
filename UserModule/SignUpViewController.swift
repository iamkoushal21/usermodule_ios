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
    case signUpFirst
    case alreadySignedUp
    case successfullySignedUp
    case fillAllTheFieldsFirst
    case emailNotValid
    case emailOrPasswordNotCorrect
    
    var title: String {
        switch self {
        case .passwordNotMatch:
            return "Password"
        case .passwordNotValid:
            return "Invalid"
        case .signUpFirst:
            return "Pease Sign Up First"
        case .alreadySignedUp:
            return "You Already Signed Up"
        case .successfullySignedUp:
            return "Successfully Signed Up"
        case .fillAllTheFieldsFirst:
            return "First Fill All The Fields"
        case .emailNotValid:
            return "Email Id is not valid"
        case .emailOrPasswordNotCorrect:
            return "Email or Password is not correct"
        }
    }
    
    var message: String? {
        switch self {
        case .passwordNotMatch:
            return "Password and Confirm Password are not same"
        case .passwordNotValid:
            return "Password should be minimum of 8 and maxinmum of 32 character having 1 special, cap, num character"
        case .signUpFirst:
            return nil
        case .alreadySignedUp:
            return nil
        case .successfullySignedUp:
            return "Now you can login from home page"
        case .fillAllTheFieldsFirst:
            return "All fields are mandatory to fill"
        case .emailNotValid:
            return nil
        case .emailOrPasswordNotCorrect:
            return nil
            
        }
    }
}

enum SegueIdentifier: String {
    case homeToSignUp
    case homeToSignIn
    case signUpToHome
    case signInToUserDetail
    
    var identifier: String {
        switch self {
        case .homeToSignUp:
            return "HomeSignUpSegue"
        case .homeToSignIn:
            return "HomeSignInSegue"
        case .signUpToHome:
            return "SignUpHomeSegue"
        case .signInToUserDetail:
            return "SignInUserDetailSegue"
        }
    }
}

struct UserDetail {
  static  var firstName = "firstName"
  static  var lastName = "lastName"
  static  var password = "password"
}

class SignUpViewController: UIViewController {
    
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
    
    var passwordValidationFlag = false
    var emailValidationFlag = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        if (firstName.isEmpty == true || lastName.isEmpty == true || emailId.isEmpty == true || password.isEmpty == true || confirmPassword.isEmpty == true) {
            showAlertViewController(alert: .fillAllTheFieldsFirst)
        } else {
            let userDetailsData: [String: Any] = [UserDetail.firstName: firstName,
                                           UserDetail.lastName: lastName,
                                           UserDetail.password: password,
                                           ]
            if UserDefaults.standard.value(forKey: emailId) != nil {
                showAlertViewController(alert: .alreadySignedUp)
            } else {
                let alertController = UIAlertController(title: "You are successfully Signed Up", message: nil, preferredStyle: .alert )
                let okay = UIAlertAction(title: "Okay", style: .cancel) { _ in
                    UserDefaults.standard.set(userDetailsData, forKey: self.emailId)
                    self.performSegue(identifier: .signUpToHome)
                }
                alertController.addAction(okay)
                present(alertController, animated: true, completion: nil )
            }
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let emailValidation = Validation.validateEmail(emailId)
        if textField == emailIdTextField, emailValidation == false, emailId.count >= 1 {
                Validation.alertIndicatorOnTextField(textField: emailIdTextField)
            showAlertViewController(alert: .emailNotValid)
            } else if emailValidation == true {
                emailValidationFlag = true
                emailIdTextField.rightViewMode = .never
            }
        if textField == passwordTextField {
            let passwordValidation = Validation.validatePassword(password)
            if passwordValidation  == false, password.count >= 1 {
                showAlertViewController(alert: .passwordNotValid)
            } else if passwordValidation {
                confirmPasswordTextField.isEnabled = true
                passwordValidationFlag = true
            }
        }
        if textField == confirmPasswordTextField, password != confirmPassword, confirmPassword.count >= 1 {
            showAlertViewController(alert: .passwordNotMatch)
            Validation.alertIndicatorOnTextField(textField: passwordTextField)
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
    
    func performSegue(identifier: SegueIdentifier) {
        performSegue(withIdentifier: identifier.identifier, sender: self)
    }
}
