//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Austin Tooley on 3/11/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    func postSession(_ username: String, password: String, completionHandlerForSession: @escaping (_ didSucceed: Bool, _ error: NSError?) -> Void) {
        
        // Specify parameters, method, and http body
        let parameters = [String:AnyObject]()
        let method: String = Methods.Session
        let jsonBody = "{\"\(UdacityClient.JSONBodyKeys.Udacity)\": {\"\(UdacityClient.JSONBodyKeys.Username)\":\"\(username)\", \"\(UdacityClient.JSONBodyKeys.Password)\":\"\(password)\"}}"
        print("Body: \(jsonBody)")
        
        
        // Make request
        let _ = taskForPostMethod(method, parameters: parameters as [String:AnyObject], jsonBody: jsonBody) { (results, error) in
        
            // Send values to completion handler
            if let error = error {
                completionHandlerForSession(false, error)
            } else {
                print("Results!: \(results)")
                // Set session
                if let sessionResult = results?[UdacityClient.JSONResponseKeys.Session] as? [String: AnyObject] {
                    UdacityClient.User.sessionID = sessionResult[UdacityClient.JSONResponseKeys.Id] as! String
                    print(UdacityClient.User.sessionID)
                }
                // Set key
                if let keyResult = results?[UdacityClient.JSONResponseKeys.Account] as? [String: AnyObject] {
                    UdacityClient.User.accountKey = keyResult[UdacityClient.JSONResponseKeys.Key] as! String
                    print(UdacityClient.User.accountKey)
                // Else error
                } else {
                    completionHandlerForSession(false, NSError(domain: "postSession parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postSession!"]))
                }
                // Successful
                if (results?[UdacityClient.JSONResponseKeys.Registered] != nil) {
                    completionHandlerForSession(true, nil)
                }
            }
        }
    }
}
