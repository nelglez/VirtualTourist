//
//  Flickr.swift
//  VirtualTourist
//
//  Created by Sam Townsend on 2019-01-04.
//  Copyright © 2019 Sam Townsend. All rights reserved.
//

import Foundation
import MapKit

class Flickr: NSObject {
    
    // MARK: Properties
    
    var session = URLSession.shared
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: GET Photos
    
    func getPhotos(coordinate: CLLocationCoordinate2D, completionHandler: @escaping (_ success: Bool, _ photos: [AnyObject?], _ error: String?)-> Void) -> Void {
        
        let parameters: [String: String] = [
            "api_key": "0f9c08d0b7e7cc75deaecb1d8a4cf05b",
            "method": "flickr.photos.search",
            "format": "json",
            "nojsoncallback": "1",
            "lat": "\(coordinate.latitude)",
            "lon": "\(coordinate.longitude)"
        ]
        
        // Create session and request
        let session = URLSession.shared
        let request = createURLRequest(method: "GET", path: "/services/rest", parameters: parameters)
        
        // Create network request
        let task = session.dataTask(with: request) { data, response, error in
            
            /* GUARD: Was there an error? */
            guard error == nil else {
                print("Error Returned: \(error.debugDescription)")
                completionHandler(false, [], error.debugDescription)
                
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No Data Returned")
                completionHandler(false, [], "No Data Returned")
                
                return
            }
            
            // Parse the data
            var parsedData: AnyObject! = nil
            
            do {
                parsedData =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            }
            catch {
                print("unable to parse json \(String(data: data, encoding: .utf8)!)")
                completionHandler(false, [], "unable to parse json")
                
                return
            }
            
            guard let photos = parsedData?["photos"] as? AnyObject,
                let photo = photos["photo"] as? [AnyObject]  else {
                    print("no photos attribute present")
                    completionHandler(false, [], "no photos attribute present")
                    
                    return
            }
            
            // Photos URL
            let photos_url = photo.map(){ photo in
                "https://farm\(photo["farm"]!!).staticflickr.com/\(photo["server"]!!)/\(photo["id"]!!)_\(photo["secret"]!!)_s.jpg"
            }
            
            completionHandler(true, photos_url as [AnyObject], nil)
        }
        task.resume()
    }
    
    // MARK: Helpers
    
    func createURLRequest(method: String , path: String , parameters: [String:String]) -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.flickr.com"
        components.path = path
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        return request
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> Flickr {
        struct Singleton {
            static var sharedInstance = Flickr()
        }
        return Singleton.sharedInstance
    }
}
