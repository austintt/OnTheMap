//
//  UdacityClientConstants.swift
//  OnTheMap
//
//  Created by Austin Tooley on 3/11/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

// MARK:  - UdacityClient (Constants)

extension UdacityClient {
    
    // MARK: API Constants
    struct Constants {
        
        // MARK: API Key
        static let ApiKey = ""
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
    }
    
    // MARK: Methods
    struct Methods {
        
        // MARK Session
        static let Session = "/session"
    }
    
    // MARK: Prameter Keys
    struct ParemeterKeys {
    }
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    // MARK JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
    
        // MARK: Account
        static let Account = "account"
        static let Registered = "registered"
        static let Key = "key"
        
        // MARK: Session
        static let Session = "session"
        static let Id = "id"
        static let Expiration = "expiration"
    
    }
    
    // Mark: User 
    struct User {
        static var sessionID = ""
        static var accountKey = ""
        static var firstName = ""
        static var lastName = ""
        static var mapString = ""
    }
    
    
}
