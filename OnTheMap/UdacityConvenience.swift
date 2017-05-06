//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Austin Tooley on 3/11/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import Foundation

extension ServiceManager {
    
    func postSession(_ username: String, password: String, completionHandlerForSession: @escaping (_ didSucceed: Bool, _ error: NSError?) -> Void) {
        
        // Specify parameters, method, and http body
        let parameters = [String:AnyObject]()
        let method: String = Methods.Session
        let url = udacityURLFromParameters(parameters, withPathExtension: method)
        let jsonBody = "{\"\(ServiceManager.JSONBodyKeys.Udacity)\": {\"\(ServiceManager.JSONBodyKeys.Username)\":\"\(username)\", \"\(ServiceManager.JSONBodyKeys.Password)\":\"\(password)\"}}"
        print("Body: \(jsonBody)")
        
        
        // Make request
        let _ = taskForPostMethod(url: url, jsonBody: jsonBody) { (results, error) in
        
            // Send values to completion handler
            if let error = error {
                completionHandlerForSession(false, error)
            } else {
                print("Results!: \(results)")
                // Set session
                if let sessionResult = results?[ServiceManager.JSONResponseKeys.Session] as? [String: AnyObject] {
                    ServiceManager.User.sessionID = sessionResult[ServiceManager.JSONResponseKeys.Id] as! String
                    print(ServiceManager.User.sessionID)
                }
                // Set key
                if let keyResult = results?[ServiceManager.JSONResponseKeys.Account] as? [String: AnyObject] {
                    ServiceManager.User.accountKey = keyResult[ServiceManager.JSONResponseKeys.Key] as! String
                    print(ServiceManager.User.accountKey)
                // Else error
                } else {
                    completionHandlerForSession(false, NSError(domain: "postSession parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postSession!"]))
                }
                // Successful
                if (results?[ServiceManager.JSONResponseKeys.Registered] != nil) {
                    completionHandlerForSession(true, nil)
                }
            }
        }
    }
    
    func getStudentInfo(parameters: [String:AnyObject], completionHandlerForStudentInfo: @escaping (_ user: User?, _ error: NSError?) -> Void) {
        // Set params
        let blankParams = [String:AnyObject]()
        var method: String = Methods.StudentInfo
        method += parameters[ServiceManager.JSONResponseKeys.Account] as! String
        var url = udacityURLFromParameters(blankParams, withPathExtension: method)
        print("URL: \(url)")
        
        
        // Make Request
        let _ = taskForGETMethod(url: url) { (results, error) in
            
            // check for error
            if let error = error {
                completionHandlerForStudentInfo(nil, error)
            } else {
                print("USER RESULTS: \(results)")
                
                //let user = self.parseUserFromJson(results: results as! [String:AnyObject])
                print("Student Info: \(String(describing: results))")
                
                completionHandlerForStudentInfo(nil, nil)
            }
            
        }
        
            // Send values to completion handler
    }
    
    func parseUserFromJson(results: [String:AnyObject]) -> User {
        var user = User()
        print("User Results: \(results)")
        
//        if let parsedResult = results
        
        return user
    }
    
    
    // Create URL from params
    private func udacityURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        // Construct URL
        var components = URLComponents()
        components.scheme = ServiceManager.Constants.UdacityApiScheme
        components.host = ServiceManager.Constants.UdacityApiHost
        components.path = ServiceManager.Constants.UdacityApiPath + (withPathExtension ?? "")
        
        components.queryItems = [URLQueryItem]()
        
        // Add params
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }

}
