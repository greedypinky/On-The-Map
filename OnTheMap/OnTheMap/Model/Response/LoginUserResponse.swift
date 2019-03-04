//
//  LoginUserResponse.swift
//  OnTheMap
//
//  Created by Rita Law on 2019-03-02.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import Foundation

// struct to store response
/*
 "account": {
 "registered": true,
 "key": "21459363"
 },
 "session": {
 "id": "9802288086S0ee83ee32705b01bcc17c4b5eb869a73",
 "expiration": "2019-04-26T00:02:44.201319Z"
 } */

struct Auth {
    static var accountId = 0
    static var sessionId = ""
}

struct Account: Codable {
    let registered:Bool
    let key:String
}
struct Session: Codable {
    let id:String
    let expiration:String
}
struct UserInfo: Codable {
    let account:Account
    let session:Session
}
