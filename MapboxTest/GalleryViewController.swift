//
//  GalleryViewController.swift
//  MapboxTest
//
//  Created by Karina on 8/20/17.
//  Copyright © 2017 Karyna Katrich. All rights reserved.
//

import UIKit
import os.log

class GalleryViewController: UITableViewController {
    
    var pointsList =  [CustomPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.register(UITableViewCell, forCellReuseIdentifier: "locationCell")
//        
//        (UIApplication.shared.delegate as! AppDelegate).addUser(user: CustomPointAnnotation(name: <#T##String#>, latitude: <#T##Double#>, longitude: <#T##Double#>)
        
        if let savedSoldiers = loadPoints() {
            pointsList += savedSoldiers
        }
        else {
            // Load the sample data.
            loadSamplePoints()
        }
    }

//    
//    func viewDidAppear(_ animated: Bool) {
//        pointList = (UIApplication.shared.delegate as! AppDelegate).getUsers()
//        self.tableView.reloadData()
//    }

//MARK: - Table view data source

override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

    // MARK: - TableView functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pointsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CustomTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CustomTableViewCell.")
        }
        
        // Fetches the appropriate soldier for the data source layout.
        let point = pointsList[indexPath.row]
        
        cell.titleLabel.text = point.title

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coordinate = pointsList[indexPath.row].coordinate
//        let latitude = poinList[indexPath.row].getLatitude()
//        let longitude = personList[indexPath.row].getLongitude()
        
        //centerMapOnLocation(CLLocation(latitude: latitude, longitude: longitude))
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //If you want to change title
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // delete data and row
            pointsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    private func savePoints() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(pointsList, toFile: CustomPointAnnotation.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("CustomPointAnnotation successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save soldiers...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadPoints() -> [CustomPointAnnotation]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: CustomPointAnnotation.ArchiveURL.path) as? [CustomPointAnnotation]
    }
    
    private func loadSamplePoints() {
        
//        let photo1 = UIImage(named: "soldier-1")
//        let photo2 = UIImage(named: "soldier-2")
//        let photo3 = UIImage(named: "soldier-3")
//        
//        guard let soldier1 = Soldier(name: "Soldier1", gender:"M", age:18, photo: photo1, rating: 4) else {
//            fatalError("Unable to instantiate soldier1")
//        }
//        
//        guard let soldier2 = Soldier(name: "Soldier2", gender:"F", age:28, photo: photo2, rating: 5) else {
//            fatalError("Unable to instantiate soldier2")
//        }
//        
//        guard let soldier3 = Soldier(name: "Soldier3", gender:"Other", age:38, photo: photo3, rating: 3) else {
//            fatalError("Unable to instantiate soldier2")
//        }
//        
//        soldiers += [soldier1, soldier2, soldier3]
//    }
//

}
}
