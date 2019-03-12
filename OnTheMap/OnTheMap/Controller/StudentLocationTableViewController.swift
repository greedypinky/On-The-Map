//
//  StudentLocationTableViewController.swift
//  OnTheMap
//
//  Created by Man Wai  Law on 2019-02-23.
//  Copyright © 2019 Rita's company. All rights reserved.
//

import UIKit

class StudentLocationTableViewController: UITableViewController {
    
    var studentInfos:[StudentInformation] = [StudentInformation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationItem.title = "On The Map"
        // A map view can be supplied with an array of annotation objects.
        // TODO: In "On the Map", you will create MKPointAnnotation objects from data that you download using the Parse API.
        let tabItems = self.tabBarController?.tabBar.items
        tabItems?[0].image = UIImage(named: "icon_mapview-deselected") // mapview tab is de-selected
        tabItems?[1].image = UIImage(named: "icon_listview-selected") // listview tab is selected
        
        ParseAPI.requestGetStudents(completionHandler: handleGetStudentInfos(infos:error:))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // prepareNavigationBarButtons(navItem:navigationItem)
        NavigationActions.initRightNavigationBarButtons(item: navigationItem, reload: #selector(NavigationActions.reload), add: #selector(NavigationActions.addStudentMapLocation))
        NavigationActions.initLeftNavigationBarButtons(item: navigationItem, logout: #selector(NavigationActions.logout))
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return studentInfos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentlocation", for: indexPath)
        
        // Configure the cell...
        var title = ""
        if let firstname = studentInfos[indexPath.row].firstName {
            title = firstname
        }
        
        if let lastname = studentInfos[indexPath.row].lastName {
            title = "\(title) \(lastname)"
        }
        
        guard title.count > 0 else {
            return cell
        }
        cell.textLabel?.text = title
        if let url = studentInfos[indexPath.row].mediaURL {
            //if !url.isEmpty {
                cell.detailTextLabel?.text = url
            print("=========== Row Title is \(title) =========")
            print("=========== Row mediaUrl is \(url) =========")
            print("=========== Result: \(cell.detailTextLabel?.text) =========")
            //}
            
        }
        cell.imageView?.image = UIImage(named: "icon_pin")
        return cell
    }
        
        
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
        
        @objc func addStudentMapLocation() {
            // Navigate to the add student information page
            print("add student")
        }
        
        
        /*
         // Override to support conditional editing of the table view.
         override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the specified item to be editable.
         return true
         }
         */
        
        /*
         // Override to support editing the table view.
         override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
         // Delete the row from the data source
         tableView.deleteRows(at: [indexPath], with: .fade)
         } else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
         }
         */
        
        /*
         // Override to support rearranging the table view.
         override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
         
         }
         */
        
        /*
         // Override to support conditional rearranging of the table view.
         override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
         }
         */
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Tapping on the row launches Safari and opens the link associated with the student.
            let selectedRow = tableView.cellForRow(at: indexPath)
            if let url = selectedRow?.detailTextLabel?.text {
                // TODO:  Open Safari from the mediaURL link
                print("need to open safari!")
                
            }
        }
        
        func handleGetStudentInfos(infos:[StudentInformation]?, error:Error?) {
            guard let infos = infos else {
                print(error!)
                return
            }
            studentInfos = infos
            print(studentInfos)
            // createMapAnnotation(studentInfos:studentInfos)
            DispatchQueue.main.async {
                // reload table
                self.tableView.reloadData()
            }
        }
        
        
        func prepareNavigationBarButtons(navItem:UINavigationItem) {
                    //        let logoutButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem., target: self, action: #selector(logout))
        
                    let logoutButton = UIBarButtonItem(image: nil, style: UIBarButtonItem.Style.plain, target: self, action: #selector(logout))
                    logoutButton.title = "LOGOUT"
                    let reloadButton = UIBarButtonItem(image: UIImage(named: "icon_refresh"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(reload))
        
                    let addButton = UIBarButtonItem(image: UIImage(named: "icon_addpin"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addStudentMapLocation))
                    //        navigationItem.setRightBarButtonItems([addButton,reloadButton], animated: true)
                    //        navigationItem.setLeftBarButton(logoutButton, animated: true)
                    navItem.setRightBarButtonItems([addButton,reloadButton], animated: true)
                    navItem.setLeftBarButton(logoutButton, animated: true)
            }
    
    
    
   
    
}
