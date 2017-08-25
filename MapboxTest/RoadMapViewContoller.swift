//
//  CustomViewContoller.swift
//  MapboxTest
//
//  Created by Karina on 8/23/17.
//  Copyright © 2017 Karyna Katrich. All rights reserved.
//

import UIKit
import Mapbox

class RoadMapViewContoller: UIViewController, MGLMapViewDelegate {

     var mapView: MGLMapView!
     var routeMaps =  [CustomPointAnnotation]()
     var selectedPhotos = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(tap:)))
        for recognizer in mapView.gestureRecognizers! where recognizer is UITapGestureRecognizer {
            singleTap.require(toFail: recognizer)
        }
        mapView.addGestureRecognizer(singleTap)
        
        // Convert `mapView.centerCoordinate` (CLLocationCoordinate2D)
        // to screen location (CGPoint).
        let centerScreenPoint: CGPoint = mapView.convert(mapView.centerCoordinate, toPointTo: mapView)
        print("Screen center: \(centerScreenPoint) = \(mapView.center)")
    }
    
    
    func handleSingleTap(tap: UITapGestureRecognizer) {
        // Convert tap location (CGPoint)
        // to geographic coordinate (CLLocationCoordinate2D).
        let tapCoordinate: CLLocationCoordinate2D = mapView.convert(tap.location(in: mapView), toCoordinateFrom: mapView)
        print("You tapped at: \(tapCoordinate.latitude), \(tapCoordinate.longitude)")
        
        // Create an array of coordinates for our polyline, starting at the center of the map and ending at the tap coordinate.
        var coordinates: [CLLocationCoordinate2D] = [mapView.centerCoordinate, tapCoordinate]
        
        routeMaps = [CustomPointAnnotation()]
        routeMaps.coordinate = tapCoordinate

        
        var pointAnnotations = [CustomPointAnnotation]()
        let count = pointAnnotations.count + 1

        routeMaps = CustomPointAnnotation(coordinate: tapCoordinate, title: title!, subtitle: "Custom Point Annotation", images: selectedPhotos)
       
        CustomPointAnnotation?.images = [selectedPhotos]
    
        // Append each annotation to the array, which will be added to the map all at once.
        pointAnnotations.append(routeMaps)

    }

    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        // Wait for the map to load before initiating the first camera movement.
        
        // Create a camera that rotates around the same center point, rotating 180°.
        // `fromDistance:` is meters above mean sea level that an eye would have to be in order to see what the map view is showing.
        let camera = MGLMapCamera(lookingAtCenter: mapView.centerCoordinate, fromDistance: 4500, pitch: 15, heading: 180)
        
        // Animate the camera movement over 5 seconds.
        mapView.setCamera(camera, withDuration: 5, animationTimingFunction: CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
    }
    
    
    func createImageView() {
        var imageView : UIImageView
        imageView.frame = CGRect(x:0,y:0,width:100,height:200)
        imageView.image = UIImage(named:"image.jpg")
        self.view.addSubview(imageView)
    }
    
    func animateImages()
    {
        var imageView : UIImageView
        let myimgArr = [selectedPhotos]
        var images = [UIImage]()
        
        for i in 0..<myimgArr.count
        {
            images.append(UIImage(named: myimgArr[i] as! String)!)
        }
        
        imageView.animationImages = images
        imageView.animationDuration = 0.04
        imageView.animationRepeatCount = 2
        imageView.startAnimating()
    }

}
