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
    
    var routeMaps =  [CustomPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.register(UITableViewCell, forCellReuseIdentifier: "locationCell")
//        
//        (UIApplication.shared.delegate as! AppDelegate).addUser(user: CustomPointAnnotation(name: <#T##String#>, latitude: <#T##Double#>, longitude: <#T##Double#>)
        
        if let savedRouteMaps = loadPoints() {
            routeMaps += savedRouteMaps
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
        return routeMaps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RoadMapTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RoadMapTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CustomTableViewCell.")
        }
        
        // Fetches the appropriate soldier for the data source layout.
        let point = routeMaps[indexPath.row]
        
        cell.titleLabel.text = point.title

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coordinate = routeMaps[indexPath.row].coordinate
//        let latitude = routeMaps[indexPath.row].getLatitude()
//        let longitude = routeMaps[indexPath.row].getLongitude()
        
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
            routeMaps.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    private func savePoints() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(routeMaps, toFile: CustomPointAnnotation.ArchiveURL.path)
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

}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "ShowDetail":
            guard let roadMapViewController = segue.destination as? RoadMapViewContoller else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedRoadMapCell = sender as? RoadMapTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedRoadMapCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedRoadMap = routeMaps[indexPath.row]
            roadMapViewController.routeMaps = [selectedRoadMap]
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
}
