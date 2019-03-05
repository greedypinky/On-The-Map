//
//  LocationPostingViewController.swift
//  OnTheMap
//
//  Created by ritalaw on 2019-03-04.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import UIKit
import MapKit

class LocationPostingViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!

    // TODO: add Address
    // TODO: add mediaURL
    // TODO: add Find Location Button
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func showLoginFailure(message: String) {
        let alertVC = NavigationActions.alertController(title: "Search Failed", actionTitle: "OK", message: "Failed: \(message)")
        show(alertVC, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: pass the info to AddLocationMapViewController
    }
}
