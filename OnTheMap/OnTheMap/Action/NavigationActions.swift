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


    static func initLeftNavigationBarButtons(item:UINavigationItem, logout:Selector?){
        let logoutButton = UIBarButtonItem(image: nil, style: UIBarButtonItem.Style.plain, target: self, action: logout)
        logoutButton.title = "LOGOUT"
        item.setLeftBarButton(logoutButton, animated: true)
    }
    
    static func initRightNavigationBarButtons(item:UINavigationItem, reload:Selector?, add:Selector?) {
        
        let reloadButton = UIBarButtonItem(image: UIImage(named: "icon_refresh"), style: UIBarButtonItem.Style.plain, target: self, action: reload)
        
        let addButton = UIBarButtonItem(image: UIImage(named: "icon_addpin"), style: UIBarButtonItem.Style.plain, target: self, action: add)
    
        item.setRightBarButtonItems([addButton,reloadButton], animated: true)
    }

    
    static func alertController(title:String, actionTitle:String, message:String) -> UIAlertController {
        // Alert controller's title for eg. "Login Failed"
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // eg. OK
        alertVC.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        return alertVC
    }
    
    // need to expose this instance method to be used in Objective-C
    @objc static func logout() {
        // Need send a request to delete the SessionID to logout
        UdacityAPI.requestPostLogout()
        print("LOGOUT!")
    }
    
    @objc static func reload() {
        // reload the info? do the latest request
        // The rightmost bar button will be a refresh button.
        // Clicking on the button will refresh the entire data set by downloading and displaying the most recent 100 posts made by students.
        print("reload!")
    }
    
    @objc static func addStudentMapLocation(view:UIViewController) {
        // Navigate to the add student information page
        print("add student")
        
//        let postLocationViewController = UIStoryboard(name: "postlocation", bundle: nil) as! PostLocationViewController
        
        // On iPhone and iPod touch devices, the view of modalViewController is always presented full screen. On iPad, the presentation depends on the value in the modalPresentationStyle property.
        //view.present(postLocationViewController, animated: true, completion: nil)
    }
    
    
    
}
