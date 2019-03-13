//
//  Location.swift
//  OnTheMap
//
//  Created by ritalaw on 2019-03-04.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import Foundation
// request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}"
struct NewLocation : Codable {
    let uniqueKey:String
    let firstName:String?
    let lastName:String?
    let mediaURL:String
    let geocode:String
    let mapString:String
    let latitude:Double
    let longtitude:Double
    
}
