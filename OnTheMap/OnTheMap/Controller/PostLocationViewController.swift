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
    var location:String?=""
    var mediaURL:String?=""
    
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
    @IBAction func postLocation(_ sender: Any) {
        
        let lat:Double = boundingRegion?.center.latitude ?? 0.0
        let long:Double = boundingRegion?.center.longitude ?? 0.0
        // found nil while unwrapping value
        let newLocation = NewLocation(uniqueKey:Auth.uniqueKey,firstName:"", lastName:"", mediaURL:mediaURL!,mapString:location!, latitude:lat, longtitude:long)
        //  let newLocation:Codable = NewLocation()
        ParseAPI.requestPostStudentInfo(postData: newLocation, completionHandler: handlePostLocationReponse(postLocationResponse:error:))
    }
   
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
            // TODO: need to fix the position for the Alert Dialog
            let alertVC = UIAlertController(title: "Add Location", message: error?.localizedDescription, preferredStyle: .alert)
            // eg. OK
            alertVC.addAction(UIAlertAction(title:"OK" , style: UIAlertAction.Style.default, handler: { (action) in
                // dismiss the page
                self.dismiss(animated: true, completion: nil)
            })
            )
            show(alertVC, sender: nil)
            return
        }
        
        // Likewise, if the submission succeeds, then the Information Posting View should be dismissed, returning the app to the Map and Table Tabbed View.
        print("Location is created at \(response.createdAt)")
        dismiss(animated: true, completion: nil)
     
    }
}
