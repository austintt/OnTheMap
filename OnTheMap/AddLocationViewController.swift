//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Austin Tooley on 4/8/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import Foundation
import UIKit

class AddLocationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var findOnMapButtonView: UIView!
    @IBOutlet weak var locationField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationField.delegate = self
        
        
    }
    
    // Cancel and go back to map view
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findOnMap(_ sender: Any) {
        
        
    }
    
    // MARK: Misc
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
