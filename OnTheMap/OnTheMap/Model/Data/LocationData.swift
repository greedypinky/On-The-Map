//
//  LocationData.swift
//  OnTheMap
//
//  Created by Rita Law on 2019-03-02.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import Foundation
class StudentLocationData {
    static let shared = StudentLocationData()
    var studentInfos:[StudentInformation]?=[]
    
    private init() {
        guard let _ = studentInfos else {
            fatalError("Error - data is not setup!")
        }
    }
    
    func setInfo(studentInfos:[StudentInformation]) {
        self.studentInfos = studentInfos
    }
}
