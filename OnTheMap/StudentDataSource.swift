//
//  StudentDataSource.swift
//  OnTheMap
//
//  Created by Austin Tooley on 6/25/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import Foundation

class StudentDataSource {
    var studentData = [Location]()
    static let sharedInstance = StudentDataSource()
    private init() {}
}
