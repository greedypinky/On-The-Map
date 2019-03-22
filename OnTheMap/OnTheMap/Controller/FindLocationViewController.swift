//
//  LocationPostingViewController.swift
//  OnTheMap
//
//  Created by ritalaw on 2019-03-04.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import UIKit
import MapKit

class FindLocationViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var worldImage: UIImageView!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var url: UITextField!
    
    @IBOutlet weak var findLocationButton: UIButton!
    
    
    var postLocation:String?
    var postMediaURL:String?
    var mapItems:[MKMapItem]?
    var boundingRegion:MKCoordinateRegion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let cancelButton = UIBarButtonItem(image: nil, style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancel))
        cancelButton.title = "Cancel"
        navigationItem.setLeftBarButton(cancelButton, animated: true)
        navigationItem.title = "Add Location"
        
    }

    @IBAction func findLocation(_ sender: Any) {
        guard let location = location.text else {
            print("location cannot be empty")
            let alert = NavigationActions.alertController(title:"Location cannot be empty!", actionTitle: "Find location failed!", message: "OK")
            // send search request
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let mediaURL = url.text else {
            print("mediaURL cannot be empty")
            let actionTitle = "Find location failed!"
            let alert = NavigationActions.alertController(title:"Media URL cannot be empty!", actionTitle: actionTitle, message: "OK")
            alert.view.center = self.view.center
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //TODO: Likewise, if the submission succeeds, then the Information Posting View should be dismissed, returning the app to the Map and Table Tabbed View.
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = location
        // request.region = mapView.region
        let localSearch = MKLocalSearch.init(request: request)
   
  
        setFinding(finding: true)
        localSearch.start { (response,error) in
            // activityView.stopAnimating()
            // handle the error
            self.setFinding(finding: false)
            guard let response = response else {
               
                print(error!)
                // dismiss
                // If the forward geocode fails, the app will display an alert view notifying the user.
                self.dismiss(animated: true, completion: nil)
                return
            }
            // else the search is successful, then show the map view
            self.mapItems = response.mapItems
            self.boundingRegion = response.boundingRegion
            self.postLocation = location
            self.postMediaURL = mediaURL
            
            if response.mapItems.count > 0 {
                self.performSegue(withIdentifier: "toPostLocationMap", sender: nil)
            }
            
            
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: pass the info to AddLocationMapViewController
        if (segue.identifier == "toPostLocationMap") {
            let postLocationVC  = segue.destination as! PostLocationViewController
            //let postLocationVC = navController.topViewController as! PostLocationViewController
            postLocationVC.boundingRegion = boundingRegion!
            postLocationVC.mapItems = mapItems!
            postLocationVC.location = postLocation!
            postLocationVC.mediaURL = postMediaURL!
        }
    }
    
    
    // If at any point the user clicks on the “Cancel” button, then the Information Posting View should be dismissed, returning the app to the Map and Table Tabbed View.
    @objc func cancel() {
        print("cancel")
        dismiss(animated: true, completion: nil)
    }
    
    func setFinding(finding:Bool) {
        if finding {
        activityIndicator.startAnimating()
        } else {
        activityIndicator.stopAnimating()
        }
    }
}


