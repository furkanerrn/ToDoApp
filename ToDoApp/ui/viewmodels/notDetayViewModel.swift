
import Foundation


class notDetayViewModel{
    var nrepo = notlarDaoRepository()
    
    func guncelle(not_id:Int,not_ad:String){
        nrepo.guncelle(not_id: not_id, not_ad: not_ad)
    }
}
