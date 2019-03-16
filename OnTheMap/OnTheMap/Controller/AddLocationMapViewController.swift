//
//  AddLocationMapViewController.swift
//  OnTheMap
//
//  Created by ritalaw on 2019-03-04.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import UIKit
import MapKit

class AddLocationMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    let searchMapQuery:String? = nil // this will be a pass in string
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Post Location"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func searchMapLocation(location:String) {
        // init the request
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Tokyo Shibuya"
        // MKCoordinateRegion
        request.region = mapView.region
        
        // do the search
        let search = MKLocalSearch()
        search.start { (response, error) in
            // how to handler
            guard let response = response else {
                print(error!)
                DispatchQueue.main.async {
                    self.showLoginFailure(message: "Error occured")
                }
                return
            }
            guard response.mapItems.count > 0 else {
                DispatchQueue.main.async {
                    self.showLoginFailure(message: "No match for location, please try again")
                }
                return
            }
            
            // TODO: how to show the result on Mapview?
            // location is found
            for mapItem in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    func showLoginFailure(message: String) {
        let alertVC = NavigationActions.alertController(title: "Search Failed", actionTitle: "OK", message: "Failed: \(message)")
        alertVC.view.center = self.view.center
        show(alertVC, sender: nil)
    }
    
}
