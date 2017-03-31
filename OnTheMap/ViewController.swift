//
//  ViewController.swift
//  OnTheMap
//
//  Created by Austin Tooley on 3/11/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //postSession
        UdacityClient.sharedInstance().postSession("tooley7@gmail.com", password: "W4]4iDKHdVfmH,Cv") { (statusCode, error) in
            if let error = error {
                print(error)
            } else {
                print("status code: \(statusCode)")
                
                if statusCode == 1 {
                    print("Success!")
                    // TODO: Update UI
                } else {
                    print("Unknown status code")
                }
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

