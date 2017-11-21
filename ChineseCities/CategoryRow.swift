import UIKit

//Delegate protocol to execute segue when a place is tapped on
protocol ViewControllerPerformSegueDelegate: class {
    func performSegueInVC(sender: CategoryRow, place: Place)
}


class CategoryRow : UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate:ViewControllerPerformSegueDelegate?
    var categoryName: String!
    var categories: [PlaceCategory]?

    }

extension CategoryRow : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCell", for: indexPath) as! PlaceCell
        
        switch categoryName {
        case "Beijing":
            cell.title.text = ((self.categories![0] as PlaceCategory).places![indexPath.row] as Place).name
            DispatchQueue.main.async(execute: { () -> Void in
                cell.imageView.image = ((self.categories![0] as PlaceCategory).places![indexPath.row] as Place).image
            })
        case "Shanghai":
            cell.title.text = ((self.categories![1] as PlaceCategory).places![indexPath.row] as Place).name
            DispatchQueue.main.async(execute: { () -> Void in
                cell.imageView.image = ((self.categories![1] as PlaceCategory).places![indexPath.row] as Place).image
            })
        case "Hangzhou":
            cell.title.text = ((self.categories![2] as PlaceCategory).places![indexPath.row] as Place).name
            
            DispatchQueue.main.async(execute: { () -> Void in
                cell.imageView.image = ((self.categories![2] as PlaceCategory).places![indexPath.row] as Place).image
            })
            
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch categoryName {
        case "Beijing":
            delegate?.performSegueInVC(sender: self, place: ((self.categories![0] as PlaceCategory).places![indexPath.row] as Place))
        case "Shanghai":
            delegate?.performSegueInVC(sender: self, place: ((self.categories![1] as PlaceCategory).places![indexPath.row] as Place))
        case "Hangzhou":
            delegate?.performSegueInVC(sender: self, place: ((self.categories![2] as PlaceCategory).places![indexPath.row] as Place))
        default:
            break
        }
    }
    
}

extension CategoryRow : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
//        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemWidth = 250 - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
