
import UIKit

class NotDetayVC: UIViewController {

    var not : Notlar? //Notlar class ından nesne türetmek için
    var viewmodel = notDetayViewModel()
    
    @IBOutlet weak var tfNotAd: UITextField!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let n = not{
            tfNotAd.text = n.not_ad
        }

    }
    @IBAction func buttonGuncelle(_ sender: Any) {
        if let na = tfNotAd.text , let k = not{
            viewmodel.guncelle(not_id: k.not_id!, not_ad: na)
        }
     }
    
    
    
    

}
