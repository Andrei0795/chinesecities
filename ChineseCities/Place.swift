//
//  Place.swift
//  ChineseCities
//
//  Created by Andrei Ionescu on 20/11/2017.
//  Copyright © 2017 Thorn Technologies. All rights reserved.
//

import Foundation
import UIKit

//These are categories that represent cities such as Beijing and Shanghai
class PlaceCategory: NSObject {
    var name: String?
    var places: [Place]?
}


//This object represents a place such as Lama Temple
//It has many attributes such as location and name
class Place: NSObject {
    var id: String?
    var name: String?
    var coordinates: String?
    var image: UIImage?
    var nameAndCity: String?
    var descriptionBig: String?
    var wikiLink: String?
    var tripLink: String?
    var chineseAdd: String?
    
    var lat: Double?
    var lon: Double?

    init(dictionary: NSDictionary) {
        id = dictionary.value(forKey: "id") as? String
        name = dictionary.value(forKey: "name") as? String
        coordinates = dictionary.value(forKey: "coordinates") as? String
        
        coordinates = coordinates?.trimmingCharacters(in: .whitespaces)
        let coordinatesArr = coordinates?.components(separatedBy: ",")
        
        lat = Double(coordinatesArr![0])
        lon = Double(coordinatesArr![1])
        
        image = UIImage.init(named: (dictionary.value(forKey: "imageName") as? String)! + ".jpeg")
        let city = dictionary.value(forKey: "city") as? String
        nameAndCity = name! + " (" + city! + ")"
        descriptionBig = dictionary.value(forKey: "description") as? String
        wikiLink = dictionary.value(forKey: "wikiLink") as? String
        tripLink = dictionary.value(forKey: "tripLink") as? String
        chineseAdd = dictionary.value(forKey: "chineseAdd") as? String
    }
}
