//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Austin Tooley on 4/8/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AddLocationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var urlLabel: UITextField!
    @IBOutlet weak var locationQuestionView: UIView!
    @IBOutlet weak var urlQuesitonView: UIView!
    @IBOutlet weak var urlField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationField.delegate = self
        locationQuestionView.isHidden = false
        urlQuesitonView.isHidden = true
    }
    
    // Cancel and go back to map view
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findOnMap(_ sender: Any) {
        if let location = locationField.text {
            // Make search request
            let request = MKLocalSearchRequest()
            request.naturalLanguageQuery = location
            
            // Search
            let search = MKLocalSearch(request: request)
            search.start(completionHandler: {(response, error) in
                if error != nil {
                    print("Error searching \(error)")
                    return
                }
                
                // Make point
                let point = MKPointAnnotation()
                point.coordinate = CLLocationCoordinate2D(latitude: response!.boundingRegion.center.latitude, longitude: response!.boundingRegion.center.longitude)
                let pinView = MKPinAnnotationView(annotation: point, reuseIdentifier: "pin")
                pinView.animatesDrop = true
                
                // Display on map
                self.prepareForNextQuestion()
                
                // Set up Region
                let radius: CLLocationDistance = 100000
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(point.coordinate, radius * 2.0, radius * 2.0)
                
                // Display on map
                performUIUpdatesOnMain {
                    self.mapView.setRegion(coordinateRegion, animated: true)
                    self.mapView.addAnnotation(pinView.annotation!)
                }
            })
        } else {
            print("No location!")
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        if let address = urlField.text {
            
        }
    }
    
    func prepareForNextQuestion() {
        locationQuestionView.isHidden = true
        urlQuesitonView.isHidden = false
    }
    
    // MARK: Misc
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        findOnMap(self)
        return true
    }
}
