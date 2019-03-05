//
//  StudentLocationMapViewController.swift
//  OnTheMap
//
//  Created by Man Wai  Law on 2019-02-23.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import UIKit
import MapKit

class StudentLocationMapViewController: UIViewController, MKMapViewDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var sessionID:String = ""
    var mapAnnotations = [MKAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "On The Map"
        // A map view can be supplied with an array of annotation objects.
        // TODO: In "On the Map", you will create MKPointAnnotation objects from data that you download using the Parse API.
        let tabItems = self.tabBarController?.tabBar.items
        tabItems?[0].image = UIImage(named: "icon_mapview-selected") // mapview tab is selected
        tabItems?[1].image = UIImage(named: "icon_listview-deselected") // listview tab is not selected
        
        ParseAPI.requestGetStudents(completionHandler: handleGetStudentInfos(studentInfos:error:))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       prepareNavigationBarButtons()
        
    }

    private func prepareNavigationBarButtons() {
//        let logoutButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem., target: self, action: #selector(logout))
        
        let logoutButton = UIBarButtonItem(image: nil, style: UIBarButtonItem.Style.plain, target: self, action: #selector(logout))
        logoutButton.title = "LOGOUT"
        let reloadButton = UIBarButtonItem(image: UIImage(named: "icon_refresh"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(reload))
        
        let addButton = UIBarButtonItem(image: UIImage(named: "icon_addpin"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addStudentMapLocation))
        navigationItem.setRightBarButtonItems([addButton,reloadButton], animated: true)
        navigationItem.setLeftBarButton(logoutButton, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   // need to expose this instance method to be used in Objective-C
    @objc func logout() {
        // Need send a request to delete the SessionID to logout
        UdacityAPI.requestPostLogout()
        print("LOGOUT!")
    }
    
    @objc func reload() {
        // reload the info? do the latest request
        // The rightmost bar button will be a refresh button.
        // Clicking on the button will refresh the entire data set by downloading and displaying the most recent 100 posts made by students.
        print("reload!")
    }
    
    @objc private func addStudentMapLocation() {
        // Navigate to the add student information page
        print("add student")
    }
    
    func handleGetStudentInfos(studentInfos:[StudentInformation]?, error:Error?) {
        guard let studentInfos = studentInfos else {
            print(error!)
            return
        }
        createMapAnnotation(studentInfos:studentInfos)
    }
    
    /*
    struct StudentInformation : Codable {
        let createdAt: String?
        let firstName: String?
        let lastName: String?
        let latitude: Double?
        let longitude: Double?
        let mapString: String?
        let mediaURL: String?
        let objectId: String?
        let uniqueKey: String?
        let updatedAt: String?
    } */

    func createMapAnnotation(studentInfos:[StudentInformation]) {
        for info in studentInfos {
            var title = ""
            guard let latitude = info.latitude else {
                continue
            }
            guard let longtitude = info.longitude else {
                continue
            }
            if let firstname = info.firstName {
                title = firstname
            }
            
            if let lastname = info.lastName {
                title = "\(title) \(lastname)"
            }
            
            let lat = CLLocationDegrees(latitude)
            let long = CLLocationDegrees(longtitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let mediaURL = info.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.title = title
            annotation.coordinate = coordinate
            annotation.subtitle = mediaURL
            mapAnnotations.append(annotation)
        }
        
        self.mapView.addAnnotations(mapAnnotations)
    }
    
    // each pin's rendering
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //
        
        let annotationId = "pin"
        // MKPinAnnotationView is optional
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId) as? MKPinAnnotationView
        
        if pinView == nil {
            
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
            pinView?.canShowCallout = true
            pinView?.pinTintColor = .red
            pinView?.rightCalloutAccessoryView = UIButton(type:.detailDisclosure)
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if (control == view.rightCalloutAccessoryView) {
            let app = UIApplication.shared
            if let url = view.annotation?.subtitle! {
                guard url != "Enter a Link To Share", !url.isEmpty else {
                    print("No Valid URL!")
                    return
                }
                app.open(URL(string: url)!, options: [:], completionHandler: nil)
            }
        }
    }
}
