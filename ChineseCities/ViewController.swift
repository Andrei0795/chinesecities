//View Controller for the guide with the sections and horizontal tables

import UIKit

class ViewController: UIViewController {
    
    //Same categories array as in app delegate
    var categories: [PlaceCategory]?
    
    //Variable used to send a place to the details VC
    var placeToSendToDetails: Place!
    
    //Send place object to details VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsViewController = segue.destination as! DetailsViewController
        detailsViewController.place = placeToSendToDetails
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get the object from app delegate and assign it to the one specific to this class
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        categories = appDelegate.placeCategories
        }
}

extension ViewController : UITableViewDelegate { }

//Implement Delegate function from category row so that the segue is executed from this  VC
extension ViewController: ViewControllerPerformSegueDelegate {
    func performSegueInVC(sender: CategoryRow, place: Place) {
        placeToSendToDetails = place
        performSegue(withIdentifier: "pushToInfo", sender: nil)
    }
}

//Standard data source methods
extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories?[section].name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryRow
        cell.categoryName = categories?[indexPath.section].name
        cell.categories = self.categories
        //assign the delegate to each cell otherise the ViewControllerPerformSegueDelegate won't work
        cell.delegate = self
        return cell
    }
    

    
}
