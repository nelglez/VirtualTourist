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
    
    
    // MARK: - Properties
    
    var pins:[Pin] = []
    var dataController: DataController!
    
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
    
    @IBAction func viewPressedToAddPin(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
            let touchedMap = sender.location(in: mapView)
            let coordinates = mapView.convert(touchedMap, toCoordinateFrom: mapView)
            let pin = Pin(context: dataController.viewContext)
            pin.latitude = Double(coordinates.latitude)
            pin.longitude = Double(coordinates.longitude)
            try? dataController.viewContext.save()
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            mapView.addAnnotation(annotation)
        }
    }
    
}
