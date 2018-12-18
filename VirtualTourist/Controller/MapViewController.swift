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
    var allowDelete = false
    
    override func viewDidLoad() {
        mapView.delegate = self
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
    // MARK: Add Pin to Map
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
        allowDelete = deleteBannerConstraint.constant == 0 ? false : true

        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pinView: MKPinAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            pinView = dequeuedView
        } else {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pinView.animatesDrop = true
        }
        
        return pinView
    }
        
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        mapView.deselectAnnotation(view.annotation, animated: true)
        if let annotation = view.annotation {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pin")
            let predicate = NSPredicate(format: "latitude == %@ AND longitude == %@", argumentArray: [annotation.coordinate.latitude, annotation.coordinate.longitude])
            fetchRequest.predicate = predicate
            
            do {
                if let result = try dataController.viewContext.fetch(fetchRequest) as? [Pin],
                    let pin = result.first {
                    if allowDelete {
                        dataController.viewContext.delete(pin)
                        try? dataController.viewContext.save()
                        mapView.removeAnnotation(annotation)
                    } else {
                        performSegue(withIdentifier: "goToCollectionView", sender: pin )
                    }
                }
            } catch {
                print("Couln't find any Pins")
            }
        }
        
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "SegueToPhotoAlbum" {
                let viewController = segue.destination as! PhotoAlbumViewController
                viewController.pin = sender as? Pin
            }
        }
}

