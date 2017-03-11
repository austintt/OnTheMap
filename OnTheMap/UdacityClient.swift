//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Austin Tooley on 3/11/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import Foundation

class UdacityClient: NSObject {
    
    // MARK: Properties
    
    // shared session
    var session = URLSession.shared
    
    // Configuration object
    // var config = UdacityConfig()
    
    // authentication state
    
    
    // MARK: Initializer
    override init() {
        super.init()
    }
    
    // MARK:  POST
    func taskForPostMethod(_ method: String, parameters: [String:AnyObject], jsonBody: String, completionHanderForPost: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        // Set the params
        
        
        
        // Build the URL, configure request
        
        
        // Make request
        
        
        // Verify request
        
        // Parse and use data
        
        
        //start the request
    }
    
    
    
}
