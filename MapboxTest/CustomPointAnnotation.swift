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

class CustomPointAnnotation: NSObject, MGLAnnotation {
    
    // As a reimplementation of the MGLAnnotation protocol, we have to add mutable coordinate and (sub)title properties ourselves.
    public var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?
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
        static let image = "image"
    }
    
    override init() {
        coordinate = CLLocationCoordinate2D()
    }
    
    //MARK: Initialization
    public init?(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, image: UIImage?) {
        
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
        self.image = image

    }
        
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}


