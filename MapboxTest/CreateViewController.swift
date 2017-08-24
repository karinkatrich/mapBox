//
//  CreateViewController.swift
//  MapboxTest
//
//  Created by Karina on 8/20/17.
//  Copyright © 2017 Karyna Katrich. All rights reserved.
//

import UIKit
import Mapbox
import os.log

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, MGLMapViewDelegate, UITextFieldDelegate {

    // Mark: - Textfields when Add
    @IBOutlet weak var nameTextField: UITextField!
    
    var mapView: MGLMapView!
    var customPointAnnotation: CustomPointAnnotation?
    var selectedPhoto: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  myTextField.delegate = self

        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)
        
        showAnnotations()

         addReturnButton()
         addValidateCreateButton()
         addFinishButton()
         addTextField()
        // updateSaveButtonState()

        // Add a single tap gesture recognizer. This gesture requires the built-in MGLMapView tap gestures (such as those for zoom and annotation selection) to fail.
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
    
    func addTextField() {
     let myTextField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200.00, height: 40.00));
        myTextField.placeholder = "Enter text here"
        myTextField.font = UIFont.systemFont(ofSize: 15)
        myTextField.borderStyle = UITextBorderStyle.roundedRect
        myTextField.autocorrectionType = UITextAutocorrectionType.no
        myTextField.keyboardType = UIKeyboardType.default
        myTextField.returnKeyType = UIReturnKeyType.done
        myTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        myTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        myTextField.delegate = self
        self.view.addSubview(myTextField)
    }
    
    func addReturnButton() {
        let button = UIButton(type: .system)
        button.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
        button.setTitle("Return", for: .normal)
        button.isSelected = true
        button.sizeToFit()
        button.center.x = self.view.center.x
        button.frame = CGRect(origin: CGPoint(x: button.frame.origin.x - 125, y: self.view.frame.size.height - button.frame.size.height - 15), size: button.frame.size)
        //        button.addTarget(self, action: #selector(RuntimeToggleLayerExample_Swift.toggleLayer(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func addValidateCreateButton() {
        let button = UIButton(type: .system)
        button.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
        button.setTitle("Validate & Create", for: .normal)
        button.isSelected = true
        button.sizeToFit()
        button.center.x = self.view.center.x
        button.frame = CGRect(origin: CGPoint(x: button.frame.origin.x, y: self.view.frame.size.height - button.frame.size.height - 15), size: button.frame.size)
        button.addTarget(self, action: #selector(saveCustomPointAnnotations), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func addFinishButton() {
        let button = UIButton(type: .system)
        button.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin]
        button.setTitle("Finish", for: .normal)
        button.isSelected = true
        button.sizeToFit()
        button.center.x = self.view.center.x
        button.frame = CGRect(origin: CGPoint(x: button.frame.origin.x + 125, y: self.view.frame.size.height - button.frame.size.height - 15), size: button.frame.size)
        //        button.addTarget(self, action: #selector(RuntimeToggleLayerExample_Swift.toggleLayer(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
      //  saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      //  updateSaveButtonState()
        navigationItem.title = textField.text
    }

    
    func handleSingleTap(tap: UITapGestureRecognizer) {
        // Convert tap location (CGPoint)
        // to geographic coordinate (CLLocationCoordinate2D).
        let tapCoordinate: CLLocationCoordinate2D = mapView.convert(tap.location(in: mapView), toCoordinateFrom: mapView)
        print("You tapped at: \(tapCoordinate.latitude), \(tapCoordinate.longitude)")
        
        // Create an array of coordinates for our polyline, starting at the center of the map and ending at the tap coordinate.
        var coordinates: [CLLocationCoordinate2D] = [mapView.centerCoordinate, tapCoordinate]
        
        customPointAnnotation = CustomPointAnnotation()
        customPointAnnotation?.coordinate = tapCoordinate
        // Remove any existing polyline(s) from the map.
        if mapView.annotations?.count != nil, let existingAnnotations = mapView.annotations {
            mapView.removeAnnotations(existingAnnotations)
        }
        
//        let polyline = CustomPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
//        
//        // Set the custom `color` property, later used in the `mapView:strokeColorForShapeAnnotation:` delegate method.
//        polyline.color = .darkGray
        
        // Add the polyline to the map. Note that this method name is singular.
       // mapView.addAnnotation(point)
        
        var pointAnnotations = [CustomPointAnnotation]()
//        for coordinate in coordinates {
                    let count = pointAnnotations.count + 1
            customPointAnnotation = CustomPointAnnotation(coordinate: tapCoordinate,
                                              title: "Custom Point Annotation",
                subtitle: nil
                )
            
            // Set the custom `image` and `reuseIdentifier` properties, later used in the `mapView:imageForAnnotation:` delegate method.
            // Create a unique reuse identifier for each new annotation image.
            customPointAnnotation?.reuseIdentifier = "customAnnotation\(count)"
            // This dot image grows in size as more annotations are added to the array.
            customPointAnnotation?.image = dot(size:5 * count)
        
            let imagePickerController = UIImagePickerController()
            
            // Only allow photos to be picked, not taken.
            imagePickerController.sourceType = .photoLibrary
            
            // Make sure ViewController is notified when the user picks an image.
            imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            present(imagePickerController, animated: true, completion: nil)
            // Append each annotation to the array, which will be added to the map all at once.
            pointAnnotations.append(customPointAnnotation!)
//        }
        
        mapView.addAnnotation(customPointAnnotation!)
    }
    
    
    func dot(size: Int) -> UIImage {
        let floatSize = CGFloat(size)
        let rect = CGRect(x: 0, y: 0, width: floatSize, height: floatSize)
        let strokeWidth: CGFloat = 1
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        
        let ovalPath = UIBezierPath(ovalIn: rect.insetBy(dx: strokeWidth, dy: strokeWidth))
        UIColor.darkGray.setFill()
        ovalPath.fill()
        
        UIColor.white.setStroke()
        ovalPath.lineWidth = strokeWidth
        ovalPath.stroke()
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        return image
    }
    
    func showAnnotations() {
        mapView.addAnnotations((UIApplication.shared.delegate as! AppDelegate).users)
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        if (annotation is MGLUserLocation) {
            return nil;
        }
            let annotationView = MGLAnnotationView(annotation: annotation, reuseIdentifier: "CMMember");
            let itemSize = CGSize(width: 49, height: 49);
            let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 49, height: 49));
        if let point = (UIApplication.shared.delegate as! AppDelegate).users.first,
            let image = point.image {
            iv.image = image
        }
        
//            iv.setProfilePicture((annotation as! Member).media, itemSize: itemSize);
            iv.center.x = annotationView.frame.width / 2;
            iv.center.y = annotationView.frame.height / 2 - 1.5;
            annotationView.addSubview(iv);
    
        return annotationView;
    }
    
    // MARK: - MGLMapViewDelegate methods
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        if let point = annotation as? CustomPointAnnotation,
            
            let image = point.image,
            let reuseIdentifier = point.reuseIdentifier {
            
            if let annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier) {
                // The annotatation image has already been cached, just reuse it.
                return annotationImage
            } else {
                // Create a new annotation image.
                return MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
            }
            
        }
        
        // Fallback to the default marker image.
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        if let annotation = annotation as? CustomPolyline {
            // Return orange if the polyline does not have a custom color.
            return annotation.color ?? .orange
        }
        
        // Fallback to the default tint color.
        return mapView.tintColor
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                customPointAnnotation?.image = selectedImage
        }
        else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
       // selectedPhoto.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func savePoint() {
        if let point = customPointAnnotation {
            (UIApplication.shared.delegate as! AppDelegate).users.append(point);
            mapView.addAnnotation(point)
            customPointAnnotation = nil;
        }
    }

    @objc private func saveCustomPointAnnotations() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(customPointAnnotation, toFile: CustomPointAnnotation.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Soldiers successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save soldiers...", log: OSLog.default, type: .error)
        }
    }

}
