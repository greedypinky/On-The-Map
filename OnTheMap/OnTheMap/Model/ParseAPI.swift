//
//  ParseAPI.swift
//  OnTheMap
//
//  Created by Rita Law on 2019-02-20.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import Foundation

struct APIRequestKey {
    static var applicationID="QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static var restapikey="QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
}

class ParseAPI {
    
    enum ParseEndpoint {
        
        case getStudentLocations(limit:String?)
        case getSingleStudent(uniqueKey:String)
        case postStudentLocation()
        
        /*
         skip - (Number) use this parameter with limit to paginate through results
         Example: https://parse.udacity.com/parse/classes/StudentLocation?limit=200&skip=400
         */
        case getMoreStudent(limit:String?, skip:String)
        
        
        var url:URL {
            
            return URL(string: self.stringValue)!
        }
        
        // calculated value
        var stringValue:String {
            
            switch self {
            case .getStudentLocations(let limit):
                if let limit = limit {
                    return "https://parse.udacity.com/parse/classes/StudentLocation?limit=\(limit)&order=-updatedAt"
                } else {
                    // get the update time by descending order
                    return  "https://parse.udacity.com/parse/classes/StudentLocation&order=-updatedAt"
                }
            case .getSingleStudent(let uniqueKey):
                return "https://parse.udacity.com/parse/classes/StudentLocation?where={uniqueKey:\(uniqueKey)}"
                
            case .postStudentLocation:
                return "https://parse.udacity.com/parse/classes/StudentLocation"
               
            default:
                return ""
            }
            
        }
        
    }
    
    
    class func requestGetStudents(completionHandler: @escaping ([StudentInformation]?,Error?)->Void) {
        // let endpoint:URL = URL(string:"https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt")!
        let endpoint:URL = ParseEndpoint.getStudentLocations(limit: "100").url
        var request = URLRequest(url: endpoint)
        request.addValue(APIRequestKey.applicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(APIRequestKey.restapikey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        let downloadTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            // guard there is data
            guard let data = data else {
                // TODO: CompleteHandler can return error
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let result = try jsonDecoder.decode(AllStudentInfo.self, from: data)
                 DispatchQueue.main.async {
                completionHandler(result.results, nil)
                }
                
            } catch {
                 DispatchQueue.main.async {
                    completionHandler(nil,error)
                }
            }
        }
        
        downloadTask.resume()
    }
    
    /*
     {
     "results":[
     {
     "createdAt":"2015-02-24T22:35:30.639Z",
     "firstName":"John",
     "lastName":"Doe",
     "latitude":37.322998,
     "longitude":-122.032182,
     "mapString":"Cupertino, CA",
     "mediaURL":"https://udacity.com",
     "objectId":"8ZEuHF5uX8",
     "uniqueKey":"1234",
     "updatedAt":"2015-03-11T02:42:59.217Z"
     }
     ]
     }
     */
    class func requestGetSingleStudentInfo() {
        
        
        
    }
    
    
    /*
     https://parse.udacity.com/parse/classes/StudentLocation?X-Parse-Application-Id=QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr&X-Parse-REST-API-Key=QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY&uniqueKey=062306453106&firstName=rita&lastName=law&mapString=Mountain View&mediaURL=https://udacity.com&latitude=37.386052&longitude=-122.083851
    */
    // class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void)
    class func requestPostStudentInfo(postData:NewLocation, completionHandler: @escaping (PostLocationResponse?,Error?)->Void) {
        let endpoint:URL = ParseEndpoint.postStudentLocation().url
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue(APIRequestKey.applicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(APIRequestKey.restapikey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: .utf8)
        
        let jsonEncoder = JSONEncoder()
        let encodedPostData = try! jsonEncoder.encode(postData)
         request.httpBody = encodedPostData
         print(encodedPostData)
        //request.url?.absoluteString
        //print("DEBUG===== \( request.url?.absoluteString) ======")
        //request.httpBody = encodedPostData.data(using: .utf8)
        let downloadTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            // guard there is data
            guard let data = data else {
                // TODO: CompleteHandler can return error
                print(error!)
                DispatchQueue.main.async {
                    completionHandler(nil,error)
                }
                return
            }
            
            // DEBUG ==============================
//            do{
//                let jsonSerial =  try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
//
//               let code = jsonSerial["code"] as! String
//
//               let err = jsonSerial["error"] as! String
//
//            } catch {
//                print(error)
//            }
            
            let jsonDecoder = JSONDecoder()
            do {
                print(data.base64EncodedString())
                
                
                let decodedData = try jsonDecoder.decode(PostLocationResponse.self, from: data)
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
    
    class func requestPutStudentInfo(postData:String, completionHandler: (String?,Error?)->Void) {
        let endpoint:URL = URL(string:"https://parse.udacity.com/parse/classes/StudentLocation/8ZExGR5uX8")!
        var request = URLRequest(url: endpoint)
        request.httpMethod = "PUT"
        request.addValue(APIRequestKey.applicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(APIRequestKey.restapikey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".data(using: .utf8)
        
        request.httpBody = postData.data(using: .utf8)
        let downloadTask = URLSession.shared.dataTask(with: endpoint) {
            (data, response, error) in
            
            
            // guard there is data
            guard let data = data else {
                // TODO: CompleteHandler can return error
                return
            }
            
            //        let jsonDecoder = JSONDecoder()
            //        do {
            //
            //           // let data = try jsonDecoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
            //           completionHandler(data,nil)
            //
            //        } catch {
            //              completionHandler(nil,error)
            //        }
        }
        
        downloadTask.resume()
    }
    
    /*
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(TMDBResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        
        return task
    }
     */
}
