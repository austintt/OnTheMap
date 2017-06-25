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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var urlLabel: UITextField!
    @IBOutlet weak var locationQuestionView: UIView!
    @IBOutlet weak var urlQuesitonView: UIView!
    @IBOutlet weak var urlField: UITextField!
    var newLocation: Location!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.stopAnimating()
        locationField.delegate = self
        urlField.delegate = self
        locationQuestionView.isHidden = false
        urlQuesitonView.isHidden = true
        newLocation = Location()
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
                    self.showError(error: "Error finding location: \(error)")
                    self.spinner.stopAnimating()
                    return
                }
                
                // Make point
                self.spinner.startAnimating()
                let point = MKPointAnnotation()
                point.coordinate = CLLocationCoordinate2D(latitude: response!.boundingRegion.center.latitude, longitude: response!.boundingRegion.center.longitude)
                let pinView = MKPinAnnotationView(annotation: point, reuseIdentifier: "pin")
                self.newLocation.latitude = response!.boundingRegion.center.latitude
                self.newLocation.longitude = response!.boundingRegion.center.longitude
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
                    self.spinner.stopAnimating()
                }
            })
        } else {
            print("No location!")
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        if let address = urlField.text {
            spinner.startAnimating()
            // Finish setting up new locaiton
            self.newLocation.mediaURL = urlField.text
            // TODO: grab user's name
            self.newLocation.firstName = "TEST"
            self.newLocation.lastName = "USER"
            
            // post locaiton
            ServiceManager.sharedInstance().postStudentLocation(newLocation) { (didSucceed, error) in
                
                if let error = error {
                    self.showError(error: "Error posting new location \(error)")
                } else {
                    print("Success posting")
                    
                    // Return
                    self.dismiss(animated: true, completion: {self.spinner.stopAnimating()})
                }
            }
        }
    }
    
    func prepareForNextQuestion() {
        locationQuestionView.isHidden = true
        urlQuesitonView.isHidden = false
    }
    
    // MARK: Misc
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func showError(error: String) {
        // Make alert
        performUIUpdatesOnMain(){
            let alertController = UIAlertController(title: "Error", message: "Issue getting locations: \(String(describing: error))", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
            }
            alertController.addAction(okAction)
            
            // Present alert
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
