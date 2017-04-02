//
//  UdacityClientConstants.swift
//  OnTheMap
//
//  Created by Austin Tooley on 3/11/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

// MARK:  - UdacityClient (Constants)

extension ServiceManager {
    
    // MARK: API Constants
    struct Constants {
        
        // MARK: API Key
        static let parseApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let parseApplicationId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        // MARK: Udacity URLs
        static let UdacityApiScheme = "https"
        static let UdacityApiHost = "www.udacity.com"
        static let UdacityApiPath = "/api"
        
        // MARK: Parse URLs
        static let ParseApiScheme = "https"
        static let ParseApiHost = "parse.udacity.com"
        static let ParseApiPath = "/parse/classes"
    }
    
    // MARK: Methods
    struct Methods {
        
        // MARK Session
        static let Session = "/session"
        static let StudentLocation = "/StudentLocation"
    }
    
    // MARK: Prameter Keys
    struct ParemeterKeys {
        static let Limit = "limit"
        static let Skip = "skip"
        static let Order = "order"
        static let Where = "where"
        static let UniqueKey = "uniqueKey"
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
