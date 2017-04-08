//
//  Location.swift
//  OnTheMap
//
//  Created by Austin Tooley on 4/2/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import Foundation

struct Location {
    var createdAt: String?
    var firstName: String?
    var lastName: String?
    var latitude: Double?
    var longitude: Double?
//    var mapString: String?
    var mediaURL: String?
    var objectId: String?
    var uniqueKey: String?
    var updatedAt: String?
    
    init (dictionary: [String: AnyObject]) {
        createdAt = dictionary[ServiceManager.JSONResponseKeys.CreatedAt] as? String
        firstName = dictionary[ServiceManager.JSONResponseKeys.FirstName] as? String
        lastName = dictionary[ServiceManager.JSONResponseKeys.LastName] as? String
        mediaURL = dictionary[ServiceManager.JSONResponseKeys.MediaUrl] as? String
        objectId = dictionary[ServiceManager.JSONResponseKeys.ObjectId] as? String
        uniqueKey = dictionary[ServiceManager.JSONResponseKeys.UniqueKey] as? String
        updatedAt = dictionary[ServiceManager.JSONResponseKeys.UpdatedAt] as? String
        latitude = dictionary[ServiceManager.JSONResponseKeys.Latitude] as? Double
//        longitude = dictionary[ServiceManager.JSONResponseKeys.Longitude] as? String
        if let longString = dictionary[ServiceManager.JSONResponseKeys.Longitude] as? Double {
            longitude = longString
        } else if let longString = dictionary[ServiceManager.JSONResponseKeys.malformedLongitude] as? Double {
            longitude = longString
        } else {
            longitude = 0.0
        }
    }

    static func locationsFromResults(_ results: [[String: AnyObject]]) -> [Location] {
        var locations = [Location]()
        
        for result in results {
            locations.append(Location(dictionary: result))
        }
        
        return locations
    }
    
}
