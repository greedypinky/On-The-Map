//
//  PostLocationViewController.swift
//  OnTheMap
//
//  Created by Man Wai  Law on 2019-03-09.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import UIKit
import MapKit

class PostLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var boundingRegion: MKCoordinateRegion?
    var mapItems: [MKMapItem]?
    
    var placeName:String?
    var mediaURL:String?

    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // set the Cancel button for the Navigation Bar
        // smapView.set
        setRegion()
        setMapAnnotation()
        navigationItem.title = "Add Location"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    /*
 struct NewLocation:Codable {
 let uniqueKey:String
 let firstName:String?
 let lastName:String?
 let mediaURL:String
 let geocode:String
 let mapString:String
 let latitude:String
 let longtitude:String
 }
 */
    @IBAction func sendPostLocationRequest(_ sender: Any) {
        // TODO: add back the NewLocation post data
//        let newLocation:NewLocation
        let lat:Double = boundingRegion?.center.latitude ?? 0.0
        let long:Double = boundingRegion?.center.longitude ?? 0.0
        let newLocation:Codable = NewLocation(uniqueKey:Auth.uniqueKey,firstName:"", lastName:"", mediaURL:mediaURL!, geocode:"",mapString:placeName!, latitude:lat, longtitude:long)
      //  let newLocation:Codable = NewLocation()
//        ParseAPI.requestPostStudentInfo(postData: NewLocation, completionHandler: handlePostLocationReponse(postlocation:error:))
        
    }
    
    func setMapAnnotation() {
        if let items = mapItems {
            for item in items {
                print("Name = \(item.name ?? "No match")")
                print("Phone = \(item.phoneNumber ?? "No Match")")
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                self.mapView.addAnnotation(annotation)
                break // only use thte first item ?
                
            }
        }
    }
    
    func setRegion() {
        if let region = boundingRegion {
            mapView.setRegion(region, animated: true)
            
        }
    }
    
    func handlePostLocationReponse(postLocationResponse:PostLocationResponse?, error:Error?) {
        
        guard let response = postLocationResponse else {
            // If the submission fails to post the data to the server, then the user should see an alert with an error message describing the failure.
            let alertVC = UIAlertController(title: "Add Location", message: error?.localizedDescription, preferredStyle: .alert)
            // eg. OK
            alertVC.addAction(UIAlertAction(title:"OK" , style: UIAlertAction.Style.default, handler: { (action) in
                // dismiss the page
                self.dismiss(animated: true, completion: nil)
            })
            )
            return
        }
        
        // Likewise, if the submission succeeds, then the Information Posting View should be dismissed, returning the app to the Map and Table Tabbed View.
        print("Location is created at \(response.createAt)")
        dismiss(animated: true, completion: nil)
     
    }
}
