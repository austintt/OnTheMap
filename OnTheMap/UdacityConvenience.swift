//
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by Austin Tooley on 3/11/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    func postSession(_ username: String, password: String, completionHandlerForSession: @escaping (_ result: Int?, _ error: NSError?) -> Void) {
        
        // Specify parameters, method, and http body
        let parameters = [String:AnyObject]()
        let method: String = Methods.Session
        let jsonBody = "{\"\(UdacityClient.JSONBodyKeys.Udacity)\": {\"\(UdacityClient.JSONBodyKeys.Username)\":\"\(username)\", \"\(UdacityClient.JSONBodyKeys.Password)\":\"\(password)\"}}"
        print("Body: \(jsonBody)")
        
        
        // Make request
        let _ = taskForPostMethod(method, parameters: parameters as [String:AnyObject], jsonBody: jsonBody) { (results, error) in
        
            // Send values to completion handler
            if let error = error {
                completionHandlerForSession(nil, error)
            } else {
                if let results = results?[UdacityClient.JSONResponseKeys.StatusCode] as? Int {
                    completionHandlerForSession(results, nil)
                } else {
                    completionHandlerForSession(nil, NSError(domain: "postSession parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postSession!"]))
                }
            }
        }
    }
}
