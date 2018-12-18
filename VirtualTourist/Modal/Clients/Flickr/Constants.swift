//
//  Constants.swift
//  VirtualTourist
//
//  Created by Sam Townsend on 2018-12-16.
//  Copyright © 2018 Sam Townsend. All rights reserved.
//

import Foundation
import UIKit

extension FlickrClient {

// MARK: - Constants

struct Constants {
        
        // MARK: API Key
        static let ApiKey = "0f9c08d0b7e7cc75deaecb1d8a4cf05b"
        
        // MARK: URLs
        static let APIScheme = "https"
        static let APIHost = "api.flickr.com"
        static let APIPath = "/services/rest"
        
        static let SearchBBoxHalfWidth = 0.2
        static let SearchBBoxHalfHeight = 0.2
        static let SearchLatRange = (-90.0, 90.0)
        static let SearchLonRange = (-180.0, 180.0)

    
    // MARK: Flickr Parameter Keys
    struct ParameterKeys {
        static let Method = "method"
        static let APIKey = "api_key"
        static let Extras = "extras"
        static let Format = "format"
        static let NoJSONCallback = "nojsoncallback"
        static let SafeSearch = "safe_search"
        static let BoundingBox = "bbox"
        static let PhotosPerPage = "per_page"
    }

    // MARK: Flickr Parameter Values
    struct ParameterValues {
        static let SearchMethod = "flickr.photos.search"
        static let APIKey = "0f9c08d0b7e7cc75deaecb1d8a4cf05b"
        static let ResponseFormat = "json"
        static let DisableJSONCallback = "1" /* 1 means "yes" */
        static let MediumURL = "url_m"
        static let UseSafeSearch = "1"
        static let PhotosPerPage = "21"
    }
}
}
