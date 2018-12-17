//
//  MapViewController.swift
//  VirtualTourist
//
//  Created by Sam Townsend on 2018-12-13.
//  Copyright © 2018 Sam Townsend. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreData


class MapViewController: UIViewController {

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var deleteBannerConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    var pins:[Pin] = []
    var dataController: DataController!
    
    var deleteAllowed = false
    
    override func viewDidLoad() {
     callFetchRequest()
    }
    
    func callFetchRequest() {
        
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        
        fetchRequest.sortDescriptors = []
        if let result = try? dataController.viewContext.fetch(fetchRequest) {
            for pin in result {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(pin.latitude), longitude: CLLocationDegrees(pin.longitude))
                mapView.addAnnotation(annotation)
            }
        }
    }
    
        @IBAction func pressMapToAddPin(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
            let pressedMap = sender.location(in: mapView)
            let coordinates = mapView.convert(pressedMap, toCoordinateFrom: mapView)
            let pin = Pin(context: dataController.viewContext)
            pin.latitude = Double(coordinates.latitude)
            pin.longitude = Double(coordinates.longitude)
            try? dataController.viewContext.save()
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            mapView.addAnnotation(annotation)
        }
    }
    
    @IBAction func pressEditButton(_ sender: Any) {
        deleteBannerConstraint.constant = deleteBannerConstraint.constant == 0 ? -70.0 : 0
        editButton.title = deleteBannerConstraint.constant == 0 ? "Edit" : "Done"
        deleteAllowed = deleteBannerConstraint.constant == 0 ? false : true
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
    }
    
}
