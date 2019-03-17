//
//  UIViewController+logout.swift
//  OnTheMap
//
//  Created by Man Wai  Law on 2019-03-16.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    @IBAction func logout() {
        
        UdacityAPI.requestPostLogout {
            //
            DispatchQueue.main.async {
                //
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func addStudentMapLocation() {
        // Navigate to the add student information page
        print("add student")
        
        let postlocationNavController = storyboard?.instantiateViewController(withIdentifier: "postLocationNavigation") as! UINavigationController
        // Present Modaly
        present(postlocationNavController, animated: true, completion: nil)
    }
    
    
}
