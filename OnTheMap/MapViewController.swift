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
import SafariServices


class MapViewController: UIViewController, UINavigationControllerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        self.navigationItem.rightBarButtonItems?[0].isEnabled = false
        self.navigationItem.rightBarButtonItems?[1].isEnabled = false
        self.toggleNavButtonsActive()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Don't fetch locations again if we already have them
        if ServiceManager.sharedInstance().locations.isEmpty {
            getLocations()
        }
    }
    
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
    
    // Refresh
    @IBAction func refreshMap(_ sender: Any) {
        getLocations()
    }
    
    // MARK: Map Functions
    
    func getLocations() {
        // Get 100 pins and display
        let params = [ServiceManager.ParemeterKeys.Limit: 100, ServiceManager.ParemeterKeys.Skip: 0]
        ServiceManager.sharedInstance().getStudentLocations(parameters: params as [String : AnyObject]) { (locations, error) in
            if let error = error {
                print("We got an error: \(error)")
            } else {
                print("Success!!!")
                
                if let locations = locations {
                    ServiceManager.sharedInstance().locations = locations
                    // Add pins to the map
                    self.addPins(locations: locations)
//                    self.toggleNavButtonsActive()
                }
            }
        }
    }
    
    
    // Locations to Pins
    func addPins(locations: [Location]) {
        
        var annotations = [MKPointAnnotation]()
        
        for location in locations  {
            // Make annotation
            if let lat = location.latitude, let long = location.longitude, let first = location.firstName, let last = location.lastName, let url = location.mediaURL {
                let annotation = MKPointAnnotation()
                annotation.title = "\(first) \(last)"
                annotation.subtitle = url
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                // Add to list
                annotations.append(annotation)
            }
            performUIUpdatesOnMain {
                self.mapView.addAnnotations(annotations)
            }
        }
    }
    
    // Setup the annotation view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let id = "pin"
        var pinView = MKPinAnnotationView()
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            pinView = dequeuedView
        } else {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            pinView.canShowCallout = true
//            pinView.animatesDrop = true
            pinView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }

        return pinView
    }
    
    // Open safar view controller when annotation button pressed
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            if let urlString = view.annotation?.subtitle {
                // Handel missing http
                var formattedURL = urlString
                if (!(urlString?.contains("http"))!) {
                    formattedURL = "http://\(urlString!)"
                }
    
                if let url = URL(string: (formattedURL)!) {
                    let safariVC = SFSafariViewController(url: url)
                    present(safariVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    // Mark: Tab bar
    // List view
    
    
    func toggleNavButtonsActive() {
        for button in self.navigationItem.rightBarButtonItems! {
            button.isEnabled = !button.isEnabled
        }
    }
    
    
}
