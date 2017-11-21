//Details VC that contains buttons, descriptions and image

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var wikipediaLink: UIButton!
    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var tripadvisorButton: UIButton!
    @IBOutlet weak var chineselanguageButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!

    //Variable that checks wether this view was presented modally or not
    var isModal: Bool = false
    
    //The Place object we use to pass all the data needed for this view
    var place: Place!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.titleLabel.text = self.place.name
            self.descriptionLabel.text = self.place.descriptionBig
            self.image.image = self.place.image
        
        if self.isModal {
            self.closeButton.alpha = 1.0
        } else {
            self.closeButton.alpha = 0.0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedDirections(sender: UIButton) {
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: place.lat!, longitude: place.lon!), addressDictionary: nil)
        // The map item is the restaurant location
        let mapItem = MKMapItem(placemark: placemark)
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeTransit]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    @IBAction func tappedTripAdvisor(sender: UIButton) {
        UIApplication.shared.openURL(URL(string: place.tripLink!)!)

    }
    
    @IBAction func tappedChineseLanguage(sender: UIButton) {
        let alert = UIAlertController(title: "Address in Chinese", message: place.chineseAdd, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tappedWikipediaLink(sender: UIButton) {
        UIApplication.shared.openURL(URL(string: place.wikiLink!)!)

    }
    
    @IBAction func tappedCloseButton(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }

}
