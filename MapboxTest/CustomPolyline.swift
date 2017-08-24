//
//  CustomPolyline.swift
//  MapboxTest
//
//  Created by Karina on 8/21/17.
//  Copyright © 2017 Karyna Katrich. All rights reserved.
//

import Mapbox

class CustomPolyline: MGLPolyline {
    // Because this is a subclass of MGLPolyline, there is no need to redeclare its properties.
    
    // Custom property that we will use when drawing the polyline.
    var color: UIColor?
}
