//
//  LoginController.swift
//  OnTheMap
//  Created by rita.law on 2019-02-20.
//  Copyright © 2019 Rita's company. All rights reserved.
// @AppSpec https://docs.google.com/document/d/1tPF1tmSzVYPSbpl7_JCeMKglKMIs3dUa4OrSAKEYNAs/pub?embedded=true

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    let signUpURL = "https://www.udacity.com/account/auth#!/signup"
    @IBOutlet weak var doNotHaveAccountLabel: UILabel!
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
        
        // Set the "Sign Up" string with underline style
        let label = doNotHaveAccountLabel?.text
        let underlineAttriString = NSMutableAttributedString(string: label!)
        let range1 = (label! as NSString).range(of: "Sign Up")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
        doNotHaveAccountLabel?.attributedText = underlineAttriString
        // set the "Sign Up" with tab gesture
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tabSignUpOpenLinkAction))
        doNotHaveAccountLabel.addGestureRecognizer(tapRecognizer)
        doNotHaveAccountLabel.isUserInteractionEnabled = true
        
    }
    
    // open URL https://www.udacity.com/account/auth#!/signup.
    @objc func tabSignUpOpenLinkAction() {
        // open Safari with the Udacity Sign-in link
        print("open url from Safari")
        if let url = URL(string: signUpURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // Click on LOGON button
    @IBAction func login(_ sender: Any) {
        // TODO: Requirement - The app informs the user if the login fails. It differentiates between a failure to connect, and incorrect credentials (i.e., wrong email or password).
        
        guard let user = userName.text , !user.isEmpty else {
            // add the alert for feedback suggestion
            showLoginFailure(message: "user name is invalid!")
            return
        }
        guard let pwd = password.text , !pwd.isEmpty else {
            // add the alert for feedback suggestion
            showLoginFailure(message: "password is invalid!")
            return
        }
        
        //        UdacityAPI.requestPostLogin(username: user, password: pwd, completionHandler: handleLoginResponse(userInfo:error:))
        let loginUser = User(username: user, password: pwd)
        let udacityLogin = Udacity.init(udacity: loginUser)
        UdacityAPI.requestPostLoginGeneric(udacityLogin: udacityLogin, responseType: UserInfo.self, completionHandler: handleLoginResponse(userInfo:error:))
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
        Auth.uniqueKey = userInfo.account.key
        performSegue(withIdentifier: "showMapInfo", sender: nil)
    }
    
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
    
}

