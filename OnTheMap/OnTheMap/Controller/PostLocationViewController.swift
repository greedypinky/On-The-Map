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
    
    var placeName:String

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
    
    @IBAction func sendPostLocationRequest(_ sender: Any) {
        // TODO: add back the NewLocation post data
//        let newLocation:NewLocation
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
    
    func handlePostLocationReponse(postlocation:PostLocationResponse?, error:Error?) {
        
        
        
    }
}
