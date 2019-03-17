//
//  NavigationActions.swift
//  OnTheMap
//
//  Created by Man Wai  Law on 2019-03-03.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import Foundation
import UIKit
class NavigationActions {

    static func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        // show(alertVC, sender: nil)
    }
    
    static func alertController(title:String, actionTitle:String, message:String) -> UIAlertController {
        // Alert controller's title for eg. "Login Failed"
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // eg. OK
        alertVC.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        return alertVC
    }
}
