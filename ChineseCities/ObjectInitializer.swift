//
//  ObjectInitializer.swift
//  ChineseCities
//
//  Created by Andrei Ionescu on 19/11/2017.
//  Copyright © 2017 Thorn Technologies. All rights reserved.
//

import Foundation
import UIKit

class ObjectInitializer: NSObject {
    
    private var placeCategories = [PlaceCategory]()
    
    //Use a JSON file stored locally
    //For the future I will use a request to fetch one from the server so that new locations can be added
    func initialiseObjects() -> [PlaceCategory] {
        if let path = Bundle.main.path(forResource: "Places", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                do{
                    
                    let json =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    // JSONObjectWithData returns AnyObject so the first thing to do is to downcast to dictionary type
                    //print(json)
                    let jsonDictionary =  json as! Dictionary<String,Any>
                    //print all the key/value from the json

                    let beijing = jsonDictionary["Beijing"] as! Array<NSDictionary>
                    let shanghai = jsonDictionary["Shanghai"] as! Array<NSDictionary>
                    let hangzhou = jsonDictionary["Hangzhou"] as! Array<NSDictionary>

                    let beijingCateg = PlaceCategory()
                    beijingCateg.name = "Beijing"
                    beijingCateg.places = [Place]()
                    
                    let shanghaiCateg = PlaceCategory()
                    shanghaiCateg.name = "Shanghai"
                    shanghaiCateg.places = [Place]()
                    
                    let hangzhouCateg = PlaceCategory()
                    hangzhouCateg.name = "Hangzhou"
                    hangzhouCateg.places = [Place]()

                    for dict in beijing {
                        let place = Place(dictionary: dict)
                        beijingCateg.places?.append(place)
                    }
                    for dict in shanghai {
                        let place = Place(dictionary: dict)
                        shanghaiCateg.places?.append(place)
                    }
                    for dict in hangzhou {
                        let place = Place(dictionary: dict)
                        hangzhouCateg.places?.append(place)
                    }
                    
                    self.placeCategories.append(beijingCateg)
                    self.placeCategories.append(shanghaiCateg)
                    self.placeCategories.append(hangzhouCateg)

                }catch let error{
                    
                    print(error.localizedDescription)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        
        return self.placeCategories
    }
}
