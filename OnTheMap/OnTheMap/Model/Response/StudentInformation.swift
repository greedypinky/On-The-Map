//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Rita Law on 2019-02-20.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import Foundation

/*
[
    "createdAt" : "2015-02-24T22:27:14.456Z",
    "firstName" : "Jessica",
    "lastName" : "Uelmen",
    "latitude" : 28.1461248,
    "longitude" : -82.75676799999999,
    "mapString" : "Tarpon Springs, FL",
    "mediaURL" : "www.linkedin.com/in/jessicauelmen/en",
    "objectId" : "kj18GEaWD8",
    "uniqueKey" : 872458750,
    "updatedAt" : "2015-03-09T22:07:09.593Z"
]
 */
struct AllStudentInfo : Codable {
    
    let results:[StudentInformation]
}

struct StudentInformation : Codable {
    let createdAt: String?
    let firstName: String?
    let lastName: String?
    let latitude: Double?
    let longitude: Double?
    let mapString: String?
    let mediaURL: String?
    let objectId: String?
    let uniqueKey: String?
    let updatedAt: String?
}


