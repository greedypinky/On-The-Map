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
    
    
    @IBOutlet weak var worldImage: UIImageView!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var url: UITextField!
    
    @IBOutlet weak var findLocationButton: UIButton!
    
    var mapItems:[MKMapItem]?
    var boundingRegion:MKCoordinateRegion?

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
            
//            let alertVC = UIAlertController(title: "Media URL cannot be empty!", message: "Find location failed!", preferredStyle: .alert)
//            // eg. OK
//            alertVC.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
            // send search request
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //TODO: Likewise, if the submission succeeds, then the Information Posting View should be dismissed, returning the app to the Map and Table Tabbed View.
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = location
        // request.region = mapView.region
        let localSearch = MKLocalSearch.init(request: request)
   
        /* var mapItems: [MKMapItem]
         An array of map items representing the search results.
         var boundingRegion: MKCoordinateRegion
         The map region that encloses the returned search results.
         */
        
        localSearch.start { (response,error) in
            // handle the error
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
            
            if response.mapItems.count > 0 {
                self.performSegue(withIdentifier: "toPostLocationMap", sender: nil)
            }
            
            
        }
        // dismiss(animated: true, completion: nil)
    }
    
    
    // TODO: add Address
    // TODO: add mediaURL
    // TODO: add Find Location Button
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
        if (segue.identifier == "toPostLocationMap") {
           let navController = segue.destination as! UINavigationController
           let postLocationVC = navController.topViewController as! PostLocationViewController
            postLocationVC.boundingRegion = boundingRegion!
            postLocationVC.mapItems = mapItems!
        }
    }
    
    
    // If at any point the user clicks on the “Cancel” button, then the Information Posting View should be dismissed, returning the app to the Map and Table Tabbed View.
    @objc func cancel() {
        print("cancel")
        dismiss(animated: true, completion: nil)
    }
}
