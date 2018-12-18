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

class PhotoAlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var pin: Pin!
    var savedImages:[Photo] = []
    
    // MARK: - CollectionView Data Source methods
    
    // Returns the number of memes in the memes array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
     //   let meme = self.memes[(indexPath as NSIndexPath).row]
        
     //   cell.sentMemesImageView?.image = meme.memedImage
     //   cell.sentMemesImageView?.contentMode = .scaleAspectFit
        
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
