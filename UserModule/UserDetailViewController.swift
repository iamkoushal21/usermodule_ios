//
//  UserDetailPageViewController.swift
//  UserModule
//
//  Created by Koushal Sharma on 29/06/17.
//  Copyright © 2017 Koushal Sharma. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var emailIdLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    var emailId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailIdLabel.text = emailId
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
