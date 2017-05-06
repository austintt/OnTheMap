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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Debug
        usernameInput.text = "Tooley7@gmail.com"
        passwordInput.text = "4iU8ekQ&/M74XZ;{"
        
        //Hide error label
        errorLabel.isHidden = true
    }
    
    private func setErrorMessage(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    private func completeLogin() {
        // Clear inputs/labels
        errorLabel.isHidden = true
        usernameInput.text = ""
        passwordInput.text = ""
        spinner.stopAnimating()
        
        // Segue
        let controller = storyboard!.instantiateViewController(withIdentifier: "MapNavigationController") as! UINavigationController
        present(controller, animated: true, completion: nil)
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
        //Hide error label
        errorLabel.isHidden = true
        spinner.startAnimating()
        
        // Grab the username and password
        if (usernameInput.text! != "" && passwordInput.text! != "") {
            
            // Get the session via postSession()
            ServiceManager.sharedInstance().postSession(usernameInput.text!, password: passwordInput.text!) { (didSucceed, error) in
                // Display error
                if let error = error {
                    print(error)
                    self.spinner.stopAnimating()
                    self.setErrorMessage(message: "Error logging in")
                } else {
                    print("Post session did succeed: \(didSucceed)")
                    if didSucceed {
                        print("Success!")
                        
                        // Set current user
                        self.setCurrentUser()
                        
                        // Segue to MapViewController
                        performUIUpdatesOnMain {
                            self.completeLogin()
                        }
                    } else {
                        self.spinner.stopAnimating()
                        // Display error
                        print("Post session did not succeed")
                        self.setErrorMessage(message: "Error logging in")
                    }
                }
            }
        } else {
            self.setErrorMessage(message: "Enter email and password to login")
        }
    }
    
    private func setCurrentUser() {
        print("USER \(ServiceManager.User.accountKey)")
        let userParams = [ServiceManager.JSONResponseKeys.Account: ServiceManager.User.accountKey]
        ServiceManager.sharedInstance().getStudentInfo(parameters: userParams as [String : AnyObject]) { (user, error) in
            
        }
        
    }
}

