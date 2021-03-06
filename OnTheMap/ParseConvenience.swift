//
//  ParseConvenience.swift
//  OnTheMap
//
//  Created by Austin Tooley on 4/1/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import Foundation

extension ServiceManager {
    
    func getStudentLocations(parameters: [String:AnyObject], completionHandlerForStudentLocations: @escaping ( _ error: NSError?) -> Void) {
    
        // Set the params, method
        let parametersWithKey = parameters
        let method: String = Methods.StudentLocation
        let url = parseURLFromParameters(parametersWithKey, withPathExtension: method)
        
        // Make the request
        let _ = taskForGETMethod(url: url) { (results, error) in
            
            // Send values to completion handler
            if let error = error {
                completionHandlerForStudentLocations(error)
            } else {
//                print("Locations: \(results)")
                //Convert to Location objects
                let locations = self.parseLocationFromJson(results: results as! [String : AnyObject])
                
                // Return successfully
                StudentDataSource.sharedInstance.studentData = locations
                completionHandlerForStudentLocations(nil)
            }
        }
        
        //Check for errors
        
        //Parse and use data
        
        //start the request
    }
    
    
    func postStudentLocation(_ location: Location, completionHandlerForPostLocation: @escaping (_ didSucceed: Bool, _ error: NSError?) -> Void) {
        
        // Specify params, method, and http body
        let parametors = [String:AnyObject]()
        let method: String = Methods.StudentLocation
        let url = parseURLFromParameters(parametors, withPathExtension: method)
        let jsonBody = "{\"\(ServiceManager.ParemeterKeys.UniqueKey)\": \"\(ServiceManager.User.accountKey)\", \"\(ServiceManager.JSONResponseKeys.FirstName)\":\"\(ServiceManager.User.firstName)\", \"\(ServiceManager.JSONResponseKeys.LastName)\":\"\(ServiceManager.User.lastName)\", \"\(ServiceManager.JSONResponseKeys.MapString)\":\"\(location.mapString)\", \"\(ServiceManager.JSONResponseKeys.MediaUrl)\":\"\(location.mediaURL!)\", \"\(ServiceManager.JSONResponseKeys.Latitude)\":\(location.latitude!), \"\(ServiceManager.JSONResponseKeys.Longitude)\":\(location.longitude!)}"
        print("URL: \(url)")
        print("Body: \(jsonBody)" )
        
        // Make request
        let _ = taskForPostMethod(url: url, jsonBody: jsonBody) { (results, error) in
           
            print(results)
            // Send values to completion handler
            // Handle error
            if let error = error {
                completionHandlerForPostLocation(false, error)
            } else {
                // Set set locaiton
                completionHandlerForPostLocation(true, nil)
            }
        }
        
    }
    
    private func parseLocationFromJson(results: [String: AnyObject]) -> [Location] {
        var locations = [Location]()
        print(results)
        if let parsedResult = results[ServiceManager.JSONResponseKeys.Results] as? [[String:AnyObject]] {
            locations = Location.locationsFromResults(parsedResult)
            print(locations[0])
        }
        
        return locations
    }
    
    // Create URL from params
    private func parseURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        // Construct URL
        var components = URLComponents()
        components.scheme = ServiceManager.Constants.ParseApiScheme
        components.host = ServiceManager.Constants.ParseApiHost
        components.path = ServiceManager.Constants.ParseApiPath + (withPathExtension ?? "")
        
        components.queryItems = [URLQueryItem]()
        
        // Add params
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
}

