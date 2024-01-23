import RxSwift
import Foundation
class anasayfaViewModel{
    var nrepo = notlarDaoRepository()
    var notlarListesi = BehaviorSubject<[Notlar]>(value: [Notlar]())
    
    init(){ //anasayfaviewmodel her çağrılışta repodaki listeyi yükler
        veritabaniKopyala()
        notlarListesi = nrepo.notlarListesi
        notlariYukle()
    }
    
    func sil(not_id:Int){
        nrepo.sil(not_id: not_id)
    }
    func ara(arananKelime:String){
        nrepo.ara(aramaKelimesi: arananKelime)
    }
    func notlariYukle(){
        nrepo.notlariYukle()
    }
    
    func veritabaniKopyala(){
    let bundleYolu = Bundle.main.path(forResource: "Notlar", ofType: ".sqlite")
    let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("Notlar.sqlite")
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: kopyalanacakYer.path){
    print("Veritabanı zaten var")
    }else{
    do{
    try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
    }catch{}
    }
    }
}
