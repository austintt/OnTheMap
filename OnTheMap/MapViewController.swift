//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Austin Tooley on 3/31/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import Foundation

import UIKit

class MapViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get 100 pins and display
        
    }
    
    // Mark: Map functions
    
    // Mark: Navigation bar
    // Logout
    @IBAction func logout(_ sender: Any) {
        print("Logging out")
        
        // Wipe session
        ServiceManager.User.sessionID = ""
        ServiceManager.User.accountKey = ""
        
        // Return to login
        performUIUpdatesOnMain {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // Pins
    
    // Refresh
    
    // Mark: Tab bar
    // List view
    
    
}
