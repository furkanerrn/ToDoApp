
import Foundation
import UIKit

class notKayitViewModel{
    var nrepo = notlarDaoRepository()
    
    func kaydet(not_ad:String){
        nrepo.kaydet(not_ad: not_ad)
        
    }
}
