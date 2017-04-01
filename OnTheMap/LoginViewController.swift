//
//  ViewController.swift
//  OnTheMap
//
//  Created by Austin Tooley on 3/11/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide error label
        errorLabel.isHidden = true
    }
    
    func setErrorMessage(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    // Dierect user to webview of Udacity account signup page
    @IBAction func signUp(_ sender: Any) {
        print("Signing Up")
        let signUpURL = URL(string: "https://www.udacity.com/account/auth#!/signup")
        let safariVC = SFSafariViewController(url: signUpURL!)
        present(safariVC, animated: true, completion: nil)
    }

    // Authenticate the user
    @IBAction func login(_ sender: Any) {
        // Grab the username and password
        if let username = usernameInput.text, let password = passwordInput.text {
            
            // Get the session via postSession()
            UdacityClient.sharedInstance().postSession(username, password: password) { (didSucceed, error) in
                // Display error
                if let error = error {
                    print(error)
                    self.setErrorMessage(message: "Error logging in")
                } else {
                    print("Post session did succeed: \(didSucceed)")
                    if didSucceed {
                        print("Success!")
                        // TODO: Update UI
                    } else {
                        // Display error
                        print("Post session did not succeed")
                        self.setErrorMessage(message: "Error logging in")
                    }
                }
            }
        }
    }
}

