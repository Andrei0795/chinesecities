//Need this class to represent the annotation object for a place
import UIKit
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var image: UIImage?
    var place: Place?

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
