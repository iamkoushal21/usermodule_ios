//
//  Validation.swift
//  UserModule
//
//  Created by Koushal Sharma on 04/07/17.
//  Copyright © 2017 Koushal Sharma. All rights reserved.
//

import Foundation
import UIKit

func validatePassword(_ password: String) -> Bool {
    let passRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$%*]).{8,32}$"
    let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passRegex)
    return passwordPredicate.evaluate(with: password)
}

func validateEmail(_ email:String) -> Bool {
    if email.isEmpty { return false }
    let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: email)
}


func alertIndicatorOnTextField(textField: UITextField) {
    let alertIndicator = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    alertIndicator.image = #imageLiteral(resourceName: "logowithborderNBGGGHGVHJG")
    textField.rightView = alertIndicator
    textField.rightViewMode = .always
}

extension UIViewController {
    
    func showAlertViewController(alert: SignUpAlertType) {
        showAlertViewController(title: alert.title, message: alert.message)
    }
    
    func showAlertViewController(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert )
        let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alertController.addAction(okay)
        present(alertController, animated: true, completion: nil)
    }
}
