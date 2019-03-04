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


    static func initNavigationBarButtons(item:UINavigationItem) {
        
        
    }

    
    
}
