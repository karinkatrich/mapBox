//
//  CustomPointAnnotation.swift
//  MapboxTest
//
//  Created by Karina on 8/21/17.
//  Copyright © 2017 Karyna Katrich. All rights reserved.
//

import UIKit
import Mapbox
import os.log

class CustomPointAnnotation: NSObject, MGLAnnotation, NSCoding{
    
    // As a reimplementation of the MGLAnnotation protocol, we have to add mutable coordinate and (sub)title properties ourselves.
    
      fileprivate var _name = "CustomPointAnnotation"
    
    public var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var images: [UIImage]
    var reuseIdentifier: String?
    
    // Custom properties that we will use to customize the annotation's image.
    // var image: UIImage?
    // var reuseIdentifier: String?
    
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("annotations")
    
    
    struct PropertyKey {
        static let coordinate = "coordinate"
        static let title = "title"
        static let subtitle = "subtitle"
        static let images = "images"
    }
    
    override init() {
        coordinate = CLLocationCoordinate2D()
        images = [UIImage()]
    }
    
    //MARK: Initialization
    public init?(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, images: [UIImage]) {
        
        // The name must not be empty
        guard !title.isEmpty else {
            return nil
        }
        
        // The name must not be empty
        guard !subtitle.isEmpty else {
            return nil
        }
  
        // Initialize stored properties.
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.images = images

    }
        
//    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, images: ) {
//        self.coordinate = coordinate
//        self.title = title
//        self.subtitle = subtitle
//        self.images = images
//    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(coordinate, forKey: PropertyKey.coordinate)
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(subtitle, forKey: PropertyKey.subtitle)
        aCoder.encode(images, forKey: PropertyKey.images)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a coordinate string, the initializer should fail.
        let coordinate = aDecoder.decodeObject(forKey: PropertyKey.coordinate) as? CLLocationCoordinate2D
        
        // The gender is required. If we cannot decode a title string, the initializer should fail.
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else {
            os_log("Unable to decode the gender for a Soldier object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // The gender is required. If we cannot decode a subtitle string, the initializer should fail.
        guard let subtitle = aDecoder.decodeObject(forKey: PropertyKey.subtitle) as? String else {
            os_log("Unable to decode the gender for a Soldier object.", log: OSLog.default, type: .debug)
            return nil
        }

        let images = aDecoder.decodeObject(forKey: PropertyKey.images) as? [UIImage]
        
        
        // Must call designated initializer.
        self.init(coordinate: coordinate!, title: title, subtitle: subtitle, images: images!)
        
    }
}


