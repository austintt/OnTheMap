////
////  UdacityClient.swift
////  OnTheMap
////
////  Created by Austin Tooley on 3/11/17.
////  Copyright © 2017 Austin Tooley. All rights reserved.
////
//
//import Foundation
//
//class UdacityClient: NSObject {
//    
//    // MARK: Properties
//    
//    // shared session
//    var session = URLSession.shared
//    
//    // Configuration object
//    // var config = UdacityConfig()
//    
//    // authentication state
//    
//    
//    // MARK: Initializer
//    override init() {
//        super.init()
//    }
//    
//    // MARK:  POST
//    func taskForPostMethod(_ method: String, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPost: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
//        
//        // Set the params
//        var parametersWithApiKey = parameters
//        print("Params: \(parameters)")
//        // TODO: do we need an API Key?
//        
//        
//        // Build the URL, configure request
//        let request = NSMutableURLRequest(url: udacityURLFromParameters(parametersWithApiKey, withPathExtension: method))
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
//        print("Request: \(request)")
//        
//        // Make request
//        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
//
//            // Verify request
//            func sendError(_ error: String) {
//                let userInfo = [NSLocalizedDescriptionKey : error]
//                completionHandlerForPost(nil, NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
//            }
//            
//            // GUARD, was there an error?
//            guard (error == nil) else {
//                sendError("There was an error with your request: \(error)")
//                return
//            }
//            
//            // GUARD, did we get a successful 2XX response?
//            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
//                sendError("Bad response status code!")
//                return
//            }
//            
//            // GUARD, was there any data returned?
//            guard let data = data else {
//                sendError("No data was returned by the request!")
//                return
//            }
//            
//            // Get rid of those stupid first 5 characters 😖
//            let range = Range(uncheckedBounds: (5, data.count))
//            let trimmedData = data.subdata(in: range)
//            
//            // Parse and use data
//            self.convertDataWithCompletionHandler(trimmedData, completionHandlerForConvertData: completionHandlerForPost)
//            
//        }
//        
//        //start the request
//        task.resume()
//        return task
//    }
//    
//    // MARK: GET
//    
//    // MARK: Helper Functions
//    
//    // Create URL from params
//    private func udacityURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
//        
//        // Construct URL
//        var components = URLComponents()
//        components.scheme = UdacityClient.Constants.ApiScheme
//        components.host = UdacityClient.Constants.ApiHost
//        components.path = UdacityClient.Constants.ApiPath + (withPathExtension ?? "")
//        
//        components.queryItems = [URLQueryItem]()
//        
//        // Add params
//        for (key, value) in parameters {
//            let queryItem = URLQueryItem(name: key, value: "\(value)")
//            components.queryItems!.append(queryItem)
//        }
//        
//        return components.url!
//    }
//    
//    // given raw JSON, return a usable object
//    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
//        print(data)
//        var parsedResult: AnyObject! = nil
//        do {
//            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
//        } catch {
//            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
//            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
//        }
//        
//        print("Parsed Result: \(parsedResult)")
//        
//        completionHandlerForConvertData(parsedResult, nil)
//    }
//
//    
//    // substitute the key for the value that is contained within the method name
//    func substituteKeyInMethod(_ method: String, key: String, value: String) -> String? {
//        if method.range(of: "{\(key)}") != nil {
//            return method.replacingOccurrences(of: "{\(key)}", with: value)
//        } else {
//            return nil
//        }
//    }
//    
//    // Shared instance
//    class func sharedInstance() -> UdacityClient {
//        struct Singleton {
//            static var sharedInstance = UdacityClient()
//        }
//        return Singleton.sharedInstance
//    }
//    
//    
//    
//    
//    
//}
