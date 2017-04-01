//
//  ViewController.swift
//  OnTheMap
//
//  Created by Austin Tooley on 3/11/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func login(_ sender: Any) {
        //postSession
        
        if let username = usernameInput.text, let password = passwordInput.text {
            print("User: \(username)")
            print("Pass: \(password)")
            UdacityClient.sharedInstance().postSession(username, password: password) { (didSucceed, error) in
                if let error = error {
                    print(error)
                } else {
                    print("Post session did succeed: \(didSucceed)")
                    
                    if didSucceed {
                        print("Success!")
                        // TODO: Update UI
                    } else {
                        print("Post session did not succeed")
                    }
                }
            }
        }
    }
}

