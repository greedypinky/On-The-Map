//
//  File.swift
//  OnTheMap
//
//  Created by Man Wai  Law on 2019-03-16.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import Foundation

struct LogoutRequest: Codable {
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
    }
}
