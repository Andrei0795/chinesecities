//The map VC where we place annotations and we show the pull up controller
import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    //This is the array of all the place objects in all the cateogories of cities
    var places = [Place]()
    //The array of place annotations
    var annotations = [PlaceAnnotation]()
    
    //We need this object to send a certain Place object to the details VC
    var placeToSendToDetails: Place!

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get all the places from all the categories
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        for category in appDelegate.placeCategories {
            for place in category.places! {
                self.places.append(place)
            }
        }
        
        //add the pullupcontroller
        addPullUpController()
        
        //Set the map delegate to self to display annotations the way we want
        mapView.delegate = self
        
        //Put all anotations on the map
        for place in self.places {
            var point = PlaceAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.lat!, longitude: place.lon!))
            point.title = place.name
            point.image = place.image
            point.place = place
            
            var isExist = false
            for annotation in self.mapView.annotations{
                if annotation.coordinate.longitude == point.coordinate.longitude && annotation.coordinate.latitude == point.coordinate.latitude{
                    isExist = true
                    point = annotation as! PlaceAnnotation
                }
            }
            if !isExist{
                self.mapView.addAnnotation(point)
                self.annotations.append(point)
            }
        }
        
        //Show annotations and moves to the region where they all are found (the user will see Beijing shanghai and hangzhou cities and annotations
        self.mapView.showAnnotations(self.annotations, animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsViewController = segue.destination as! DetailsViewController
        detailsViewController.place = placeToSendToDetails
        detailsViewController.isModal = true
    }
    
    private func addPullUpController() {
        guard
            let pullUpController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
            else { return }
        pullUpController.places = self.places
        
        addPullUpController(pullUpController)
    }
    
    //Function used to zoom to annotation on the map (called from the search VC)
    func zoom(to location: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    //Function that programatically resizes image
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //Annotation View when tapped
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // If annotation is not of type RestaurantAnnotation (MKUserLocation types for instance), return nil
        if !(annotation is PlaceAnnotation){
            return nil
        }
        
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = true
        }else{
            annotationView?.annotation = annotation
        }
        
        let restaurantAnnotation = annotation as! PlaceAnnotation
        
        //Having problems with this
        //TODO: Fix and show the title below annotation. Problem now is that titles are randomly assigned to annotatiosn
        
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        label.center = (annotationView?.center)!
//        label.textAlignment = .center
//        label.numberOfLines = 5
//        label.font = UIFont.boldSystemFont(ofSize: 10)
//        label.text = restaurantAnnotation.title!
//        label.frame.origin.y = 0.5
//        annotationView?.addSubview(label)
        
        let imageView = UIImageView(image: self.resizeImage(image: restaurantAnnotation.image!, targetSize: CGSize(width: 85.0, height: 60.0)))
        imageView.contentMode = .scaleToFill
        annotationView?.detailCalloutAccessoryView = imageView
        
        // Right accessory view
        let image = UIImage(named: "arrow")
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.setImage(image, for: UIControlState())
        annotationView?.rightCalloutAccessoryView = button
        return annotationView
    }
    
    //What happens when an annotation accessory is tapped - show the details VC
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let placeAnnotation = view.annotation as! PlaceAnnotation
        placeToSendToDetails = placeAnnotation.place
        performSegue(withIdentifier: "pushToInfo2", sender: nil)

    }
    
}

