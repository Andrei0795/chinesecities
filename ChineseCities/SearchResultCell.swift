//This is needed in the PullUpController and is a text label cell in the table view
import UIKit

class SearchResultCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
