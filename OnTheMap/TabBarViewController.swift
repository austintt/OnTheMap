//
//  TabBarViewController.swift
//  OnTheMap
//
//  Created by Austin Tooley on 6/24/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItems?[0].isEnabled = true
        self.navigationItem.rightBarButtonItems?[1].isEnabled = true
        
    }
    
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
    
    @IBAction func addLocation(_ sender: Any) {
        let addLocationController = self.storyboard?.instantiateViewController(withIdentifier: "AddLocationViewController") as! AddLocationViewController
        present(addLocationController, animated: true, completion: nil)
    }
    
    
    // Refresh
//    @IBAction func refreshMap(_ sender: Any) {
//        getLocations()
//    }
}
