//
//  LoginUser.swift
//  OnTheMap
//
//  Created by Man Wai  Law on 2019-02-24.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import Foundation

struct Udacity:Codable {
    
    let udacity:User
}

// struct to store the login credentials for request
struct User:Codable {
    
    let username:String
    let password:String
    
}

