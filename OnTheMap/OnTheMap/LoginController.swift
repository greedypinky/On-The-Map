//
//  LoginController.swift
//  OnTheMap
//  Created by rita.law on 2019-02-20.
//  Copyright © 2019 Rita's company. All rights reserved.
// @AppSpec https://docs.google.com/document/d/1tPF1tmSzVYPSbpl7_JCeMKglKMIs3dUa4OrSAKEYNAs/pub?embedded=true

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var sessionID:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        // put your code here
        resetLogin()
    }

    // Click on LOGON button
    @IBAction func login(_ sender: Any) {
        // TODO: Requirement - The app informs the user if the login fails. It differentiates between a failure to connect, and incorrect credentials (i.e., wrong email or password).
        
        guard let user = userName.text , !user.isEmpty else {
            return
        }
        guard let pwd = password.text , !pwd.isEmpty else {
            return
        }
 
        // Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: '-[UIKeyboardTaskQueue waitUntilAllTasksAreFinished] may only be called from the main thread.'
        
        
        UdacityAPI.requestPostLogin(username: user, password: pwd, completionHandler: handleLoginResponse(userInfo:error:))

    }
    
    // should be getting back a list of Student Information ?
    /* {
        "account":{
        "registered":true,
        "key":"3903878747"
        },
        "session":{
        "id":"1457628510Sc18f2ad4cd3fb317fb8e028488694088",
        "expiration":"2015-05-10T16:48:30.760460Z"
        }
    } */
    func handleLoginResponse(userInfo:UserInfo?, error:Error?) {
       // 1. Get back the session ID
       // 2. then trigger another request ?
       // eg. DogAPI.requestImageFile(url: imageURL, completionHandler: self.handleImageResponse(image:error:))
       // get back the StudentInformation LIST, past to the segue when prepare the Seqgue
        guard let userInfo = userInfo else {
           print("Login error \(error!)")
           showLoginFailure(message: NSLocalizedString("Failed to login", comment: "Failed to login"))
           return
        }
        Auth.sessionId = userInfo.session.id
        performSegue(withIdentifier: "showMapInfo", sender: nil)
    }
    
    // Could not cast value of type 'UITabBarController' (0x1170075c0) to
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showMapInfo" {
//            let tabBarController = segue.destination as! UITabBarController
//            let navControlller = tabBarController.viewControllers![0] as! UINavigationController
//            let mapViewController = navControlller.topViewController as! StudentLocationMapViewController
//            mapViewController.sessionID = sessionID!
//            // exception 'NSInternalInconsistencyException', reason: '-[UIKeyboardTaskQueue waitUntilAllTasksAreFinished] may only be called from the main thread.
//        }
//    }
    
    private func resetLogin() {
        userName.text = ""
        password.text = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // enable the LOGIN button
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
    }
}

