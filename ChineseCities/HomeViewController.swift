//Home VC is the first view in the Tab Bar
//It has many labels and images and uses autolayout and some changes to constraints are done programatically

import UIKit

//Use this to check the size of the device screen
//Used for some constraints and showing images
extension UIScreen {
    
    enum SizeType: CGFloat {
        case Unknown = 0.0
        case iPhone4 = 960.0
        case iPhone5 = 1136.0
        case iPhone6 = 1334.0
        case iPhone6Plus = 1920.0
    }
    
    var sizeType: SizeType {
        let height = nativeBounds.height
        guard let sizeType = SizeType(rawValue: height) else { return .Unknown }
        return sizeType
    }
}

class HomeViewController: UIViewController {

    
    @IBOutlet weak var shanghai: UIView!
    @IBOutlet weak var beijing: UIView!
    @IBOutlet weak var hangzhou: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    
    //Labels that we need to hide for iPhone 5 or lower
    @IBOutlet weak var labelThatShouldDissapear1: UILabel!
    @IBOutlet weak var labelThatShouldDissapear2: UILabel!
    @IBOutlet weak var labelThatShouldDissapear3: UILabel!
    @IBOutlet weak var labelThatShouldDissapear4: UILabel!
    @IBOutlet weak var labelThatShouldDissapear5: UILabel!
    @IBOutlet weak var labelThatShouldDissapear6: UILabel!
    @IBOutlet weak var labelThatShouldDissapear7: UILabel!
    @IBOutlet weak var labelThatShouldDissapear8: UILabel!
    @IBOutlet weak var labelThatShouldDissapear9: UILabel!
    @IBOutlet weak var labelThatShouldDissapear10: UILabel!
    @IBOutlet weak var labelThatShouldDissapear11: UILabel!
    @IBOutlet weak var labelThatShouldDissapear12: UILabel!
    @IBOutlet weak var labelThatShouldDissapear13: UILabel!
    @IBOutlet weak var labelThatShouldDissapear14: UILabel!
    @IBOutlet weak var labelThatShouldDissapear15: UILabel!
    @IBOutlet weak var labelThatShouldDissapear16: UILabel!

    //Constraints that we need to change depending on the device screen
    @IBOutlet weak var hangzhouLeadingConstr: NSLayoutConstraint!
    @IBOutlet weak var hangzhouTopConstr: NSLayoutConstraint!
    @IBOutlet weak var beijingshanghaiHorizSpaceConstr: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Make the corners round
        self.shanghai.layer.masksToBounds = true
        self.beijing.layer.masksToBounds = true
        self.hangzhou.layer.masksToBounds = true
        
        self.shanghai.layer.cornerRadius = 5
        self.beijing.layer.cornerRadius = 5
        self.hangzhou.layer.cornerRadius = 5
        self.mainView.layer.cornerRadius = 5
        
        if UIScreen.main.sizeType == .iPhone4 || UIScreen.main.sizeType == .iPhone5{
            labelThatShouldDissapear1.alpha = 0.0;
            labelThatShouldDissapear2.alpha = 0.0;
            labelThatShouldDissapear3.alpha = 0.0;
            labelThatShouldDissapear4.alpha = 0.0;
            labelThatShouldDissapear5.alpha = 0.0;
            labelThatShouldDissapear6.alpha = 0.0;
            labelThatShouldDissapear7.alpha = 0.0;
            labelThatShouldDissapear8.alpha = 0.0;
            labelThatShouldDissapear9.alpha = 0.0;
            labelThatShouldDissapear10.alpha = 0.0;
            labelThatShouldDissapear11.alpha = 0.0;
            labelThatShouldDissapear12.alpha = 0.0;
            labelThatShouldDissapear13.alpha = 0.0;
            labelThatShouldDissapear14.alpha = 0.0;
            labelThatShouldDissapear15.alpha = 0.0;
            labelThatShouldDissapear16.alpha = 0.0;
            
            self.hangzhouLeadingConstr.constant = 50
            self.beijingshanghaiHorizSpaceConstr.priority = 1000
            self.view.layoutIfNeeded()

        }
        
        if UIScreen.main.sizeType == .iPhone6Plus{
            self.hangzhouTopConstr.constant = 50
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Credits and Info :)
    @IBAction func tappedMoreInfo(sender: UIButton) {
        let alert = UIAlertController(title: "Credits & More Info", message: "This app was developed in my free time in a few days to help some students find tourist attractions during a University of Manchester Chinese programme. \n All pictures were taken by me and are subject to copyright. The code base is also copyrighted though it contains classes from other projects.\n Nevertheless, credits for some frameworks and code go to MarioIannotta(Github) and ThornTechPublic(Github). Also credits for icons go to icons8.com. \nThanks for using the app! \nAndrei Tudor Ionescu (andreitudorionescu.com) :)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

}
