//
//  Validation.swift
//  UserModule
//
//  Created by Koushal Sharma on 04/07/17.
//  Copyright © 2017 Koushal Sharma. All rights reserved.
//

import Foundation
import UIKit

enum Regex {
    case password
    case email
    
    var format: String {
        switch self {
        case .password:
            return "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$%*]).{8,32}$"
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        }
    }
    
    func validate(_ string: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", self.format)
        return predicate.evaluate(with: string)
    }
}

struct Validation {
    static func validatePassword(_ password: String) -> Bool {
        return Regex.password.validate(password)
    }
    
    static func validateEmail(_ email: String) -> Bool {
        if email.isEmpty { return false }
        return Regex.email.validate(email)
    }
    
    static func alertIndicatorOnTextField(textField: UITextField) {
        let alertIndicator = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        alertIndicator.image = #imageLiteral(resourceName: "logowithborderNBGGGHGVHJG")
        textField.rightView = alertIndicator
        textField.rightViewMode = .always
    }
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
