//
//  PostLocationResponse.swift
//  OnTheMap
//
//  Created by ritalaw on 2019-03-12.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import Foundation
/*{
 "createdAt":"2015-03-11T02:48:18.321Z",
 "objectId":"CDHfAy8sdp"
 } */
struct PostLocationResponse :Codable {
    let createAt:String
    let objectId:String
}
