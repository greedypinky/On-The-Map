//
//  UdacityAPI.swift
//  OnTheMap
//
//  Created by Rita Law on 2019-02-20.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import Foundation


class UdacityAPI {
    
    enum UdacityEndpoint:String {
        case login = "https://onthemap-api.udacity.com/v1/session"
        var url:URL{
            return URL(string:self.rawValue)!
        }
    }
    
    // struct to store the login credentials
    //    struct User:Codable {
    //
    //        let username:String
    //        let password:String
    //
    //    }
    // struct to store reply
    /*
     "account": {
     "registered": true,
     "key": "21459363"
     },
     "session": {
     "id": "9802288086S0ee83ee32705b01bcc17c4b5eb869a73",
     "expiration": "2019-04-26T00:02:44.201319Z"
     } */
    
    //    struct Account: Codable {
    //        let register:Bool
    //        let key:String
    //    }
    //    struct Session: Codable {
    //        let id:String
    //        let expiration:String
    //    }
    //    struct UserSession: Codable {
    //        let account:Account
    //        let session:Session
    //    }
    
    /*
     URL:  https://onthemap-api.udacity.com/v1/session
     POST
     Required Parameters:
     udacity - (Dictionary) a dictionary containing a username/password pair used for authentication
     username - (String) the username (email) for a Udacity student
     password - (String) the password for a Udacity student
     */
    class func requestPostLogin(username:String, password:String, completionHandler: @escaping (UserInfo?,Error?)->Void) {
        let endpoint:URL = UdacityEndpoint.login.url
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let loginUser = User(username: username, password: password)
        let udacity = Udacity.init(udacity: loginUser)
        let jsonEncoder = JSONEncoder()
        let postData = try! jsonEncoder.encode(udacity)
        print(postData)
        // request.httpBody = "{\"udacity\": {\"username\": \"account@domain.com\", \"password\": \"********\"}}".data(using: .utf8)
        
        //        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: .utf8)
        
        // request.httpBody = postData.data(using: .utf8)
        request.httpBody = postData
        let downloadTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            // guard there is data
            guard let data = data else {
                // TODO: CompleteHandler can return error
                completionHandler(nil,error)
                return
            }
            // FOR ALL RESPONSES FROM THE UDACITY API, YOU WILL NEED TO SKIP THE FIRST 5 CHARACTERS OF THE RESPONSE
            print("data ======= \(data)")
            print(data.count)
            let range = 5..<data.count
            let newData = data.subdata(in: range) /* subset response data! */
            print(String(data: newData, encoding: .utf8)!)
            /*
             {"session":{"id":"1323367955S23041eaf2d73b2080a6a49245d84b681","expiration":"2019-04-28T07:27:21.172435Z"},"account":{"registered":true,"key":"1165135862"}}
             */
            let jsonDecoder = JSONDecoder()
            do {
                let decodedData = try jsonDecoder.decode(UserInfo.self, from: newData)
                print(decodedData)
                DispatchQueue.main.async {
                    completionHandler(decodedData,nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(nil,error)
                }
            }
        }
        downloadTask.resume()
    }
    
    class func requestPostLoginGeneric<RequestType:Encodable,ResponseType:Decodable>(udacityLogin:RequestType,responseType:ResponseType.Type, completionHandler: @escaping (ResponseType?,Error?)->Void) {
        let endpoint:URL = UdacityEndpoint.login.url
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
//        let loginUser = User(username: username, password: password)
//        let udacity = Udacity.init(udacity: loginUser)
        let jsonEncoder = JSONEncoder()
        let postData = try! jsonEncoder.encode(udacityLogin)
        print(postData)
        // request.httpBody = "{\"udacity\": {\"username\": \"account@domain.com\", \"password\": \"********\"}}".data(using: .utf8)
        
        //        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: .utf8)
        
        // request.httpBody = postData.data(using: .utf8)
        request.httpBody = postData
        let downloadTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            // guard there is data
            guard let data = data else {
                // TODO: CompleteHandler can return error
                completionHandler(nil,error)
                return
            }
            // FOR ALL RESPONSES FROM THE UDACITY API, YOU WILL NEED TO SKIP THE FIRST 5 CHARACTERS OF THE RESPONSE
            print("data ======= \(data)")
            print(data.count)
            let range = 5..<data.count
            let newData = data.subdata(in: range) /* subset response data! */
            print(String(data: newData, encoding: .utf8)!)
            /*
             {"session":{"id":"1323367955S23041eaf2d73b2080a6a49245d84b681","expiration":"2019-04-28T07:27:21.172435Z"},"account":{"registered":true,"key":"1165135862"}}
             */
            let jsonDecoder = JSONDecoder()
            do {
                // let decodedData = try jsonDecoder.decode(UserInfo.self, from: newData)
                let decodedData = try jsonDecoder.decode(ResponseType.self, from: newData)
                print(decodedData)
                DispatchQueue.main.async {
                    completionHandler(decodedData,nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(nil,error)
                }
            }
        }
        downloadTask.resume()
    }
    
    
    class func requestPostLogout(completion: @escaping () -> Void) {
        
        let endpoint:URL = UdacityEndpoint.login.url
        var request = URLRequest(url: endpoint)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN"{
                xsrfCookie = cookie
            }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            
            let range = 5..<data!.count
            let newData = data?.subdata(in: range)
            Auth.accountId = 0
            Auth.sessionId = ""
            Auth.uniqueKey = ""
            completion()
            /* subset response data! */
        }
        task.resume()
        
    }
    
}

