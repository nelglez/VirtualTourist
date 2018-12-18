//
//  PhotoAlbumViewController.swift
//  VirtualTourist
//
//  Created by Sam Townsend on 2018-12-13.
//  Copyright © 2018 Sam Townsend. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreData

class PhotoAlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {

    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    // MARK: - Properties
    
    var pin: Pin!
    var savedImages:[Photo] = []
    var dataController: DataController!
    
    
    // MARK: Life Cycle methods
    
    override func viewDidLoad() {
        
     //   setupFetchResultsController()
        setupMapView()
    }
    
//    func setupFetchResultsController() {
//
//        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
//        let predicate = NSPredicate(format: "pin == %@", argumentArray: [pin])
//        fetchRequest.predicate = predicate
//
//        if let result = try? dataController.viewContext.fetch(fetchRequest) {
//            notes = result
//        }
//
//    }
    
    func setupMapView() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(pin.latitude), CLLocationDegrees(pin.longitude))
        mapView.addAnnotation(annotation)
        
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: - CollectionView Data Source methods
    
    // Returns the number of memes in the memes array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
       // cell.activityIndicator.startAnimating()
       // cell.initWithPhoto(savedImages[indexPath.row])
        return cell

    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
//
//        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemesDetailViewController") as! MemesDetailViewController
//
//        detailController.selectedMeme = self.memes[(indexPath as NSIndexPath).row]
//
//        navigationController!.pushViewController(detailController, animated: true)
//    }
}
