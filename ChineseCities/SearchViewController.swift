//Main class for doing the search in the PullUp VC
import UIKit
import MapKit

class SearchViewController: PullUpController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var visualEffectView: UIVisualEffectView!
    @IBOutlet private weak var searchBoxContainerView: UIView!
    @IBOutlet private weak var searchSeparatorView: UIView! {
        didSet {
            searchSeparatorView.layer.cornerRadius = searchSeparatorView.frame.height/2
        }
    }
    @IBOutlet private weak var firstPreviewView: UIView!
    @IBOutlet private weak var secondPreviewView: UIView!
    @IBOutlet weak var tableView: UITableView!

    //the same object found in the Map VC
    var places = [Place]()

    //Text in the search box that gets constatly updated
    var searchString: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.attach(to: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.layer.cornerRadius = 12
    }
    
    // MARK: - PullUpController
    override var pullUpControllerPreferredSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: secondPreviewView.frame.maxY)
    }
    
    override var pullUpControllerPreviewOffset: CGFloat {
        return searchBoxContainerView.frame.height
    }
    
    override var pullUpControllerMiddleStickyPoints: [CGFloat] {
        return [firstPreviewView.frame.maxY]
    }
    
    override var pullUpControllerIsBouncingEnabled: Bool {
        return false
    }
    
    override var pullUpControllerPreferredLandscapeFrame: CGRect {
        return CGRect(x: 5, y: 5, width: 280, height: UIScreen.main.bounds.height - 10)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let lastStickyPoint = pullUpControllerAllStickyPoints.last {
            pullUpControllerMoveToVisiblePoint(lastStickyPoint, completion: nil)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchString = searchBar.text
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell",
                                                     for: indexPath) as? SearchResultCell
            else { return UITableViewCell() }
        cell.configure(title: places[indexPath.row].nameAndCity!)

        
        return cell
    }
    
    //Initially the height was set to automatic but a fixed size of 50 is preffered (though not correct if text is very large)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchString != nil && searchString != "" {
            if places[indexPath.row].name?.lowercased().range(of:searchString!.lowercased()) != nil {
                return 50
            } else {
                return 0

            }
        } else {
            return 50
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        view.endEditing(true)
        pullUpControllerMoveToVisiblePoint(pullUpControllerMiddleStickyPoints[0], completion: nil)
        
        //call the function in the Map VC to zoom to annotation
        (parent as? MapViewController)?.zoom(to: CLLocationCoordinate2D(latitude: places[indexPath.row].lat!, longitude: places[indexPath.row].lon!))
    }
}
