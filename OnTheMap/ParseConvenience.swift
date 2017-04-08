//
//  ParseConvenience.swift
//  OnTheMap
//
//  Created by Austin Tooley on 4/1/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import Foundation

extension ServiceManager {
    
    func getStudentLocations(parameters: [String:AnyObject], completionHandlerForStudentLocations: @escaping (_ locations: [Location]?, _ error: NSError?) -> Void) {
    
        // Set the params, method
        let parametersWithKey = parameters
        let method: String = Methods.StudentLocation
        let url = parseURLFromParameters(parametersWithKey, withPathExtension: method)
        
        // Make the request
        let _ = taskForGETMethod(url: url) { (results, error) in
            
            // Send values to completion handler
            if let error = error {
                completionHandlerForStudentLocations(nil, error)
            } else {
                print("Locations: \(results)")
                //Convert to Location objects
            }
            
        }
        
        //Check for errors
        
        //Parse and use data
        
        //start the request
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

