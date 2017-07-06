//
//  ForgotPassWordPageViewController.swift
//  UserModule
//
//  Created by Koushal Sharma on 29/06/17.
//  Copyright © 2017 Koushal Sharma. All rights reserved.
//

import UIKit
import MessageUI

class ForgotPasswordViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var emailIdTextField: UITextField!
    
    var emailId: String {
        return emailIdTextField.text ?? ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func sendNewPasswordButtonTapped(_ sender: Any) {
        if emailId.isEmpty {
            showAlertViewController(alert: .emailNotValid)
        } else {
                let mailComposer = MFMailComposeViewController()
                mailComposer.mailComposeDelegate = self
                mailComposer.setToRecipients(["7rcksh@gmail.com"])
                mailComposer.setSubject("New Password")
                mailComposer.setMessageBody("Set Password", isHTML: false)
                present(mailComposer, animated: true, completion: nil)
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  }
