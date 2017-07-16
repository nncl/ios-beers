import UIKit

class ViewController: UIViewController {
    
    var beer: Beer!
  
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = beer.name;
        lblDate.text = "Primeira fabricação em \(beer.firstBrewed)";
        lblDescription.text = beer.description;
    }
}



