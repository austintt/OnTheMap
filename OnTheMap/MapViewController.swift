//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Austin Tooley on 3/31/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import Foundation

import UIKit
import MapKit


class MapViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get 100 pins and display
        let params = [ServiceManager.ParemeterKeys.Limit: 100, ServiceManager.ParemeterKeys.Skip: 0]
        ServiceManager.sharedInstance().getStudentLocations(parameters: params as [String : AnyObject]) { (locations, error) in
            if let error = error {
                print("We got an error: \(error)")
            } else {
                print("Success!!!")
                
                self.addPins(locations: locations!)
                
            }
        }
        
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
    func addPins(locations: [Location]) {
        
        for location in locations {
            let pin = MKPointAnnotation()
            if let lat = location.latitude, let long = location.longitude {
                pin.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                performUIUpdatesOnMain {
                    self.map.addAnnotation(pin)
                }
            }
        }
    }
    
    // Refresh
    
    // Mark: Tab bar
    // List view
    
    
}
