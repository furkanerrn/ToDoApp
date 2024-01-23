import Foundation
import RxSwift
import UIKit
class notlarDaoRepository{
    var notlarListesi = BehaviorSubject<[Notlar]>(value:[Notlar]())
    let db : FMDatabase?
    
    
    init(){
        //notlar reposu her çağrıldığında çalışacak veritabanı kodları 
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let  veritabanıURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("Notlar.sqlite")
        db = FMDatabase(path: veritabanıURL.path) //db nin veritabanına erişmesi
    }
    
    func kaydet(not_ad:String){
        db?.open()
        do{
           try db!.executeUpdate("INSERT INTO notlar (notad) values(?)", values: [not_ad])
          }
        catch{
            print(error.localizedDescription)
        }
        db?.close()
        }
    
    
    func guncelle(not_id:Int,not_ad:String){
        db?.open()
        do{
           try db!.executeUpdate("UPDATE notlar set notad = ? where id = ?", values: [not_ad,not_id])
            print("Not güncellendi :\(not_ad)")
            
          }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        }
    
    
    func sil(not_id: Int){
        db?.open()
        do{
           try db!.executeUpdate("delete from notlar where id = ?", values: [not_id])
            notlariYukle() //Silme işleminde sonra kalanları görmek için tekrar çağırıyoruz
            print("Not silindi \(not_id)")
            
          }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        notlariYukle()
    }
     
    func ara(aramaKelimesi:String){
        db?.open()
         var liste = [Notlar]() //db den gelecek nesneler için array oluşturmak
        do{
            let rs = try db!.executeQuery("select * from notlar where notad like '%\(aramaKelimesi)%'", values: nil) //
            
            while rs.next(){
                //Gelecek değerleri arayüze basmak
                let not = Notlar(not_id: Int(rs.string(forColumn: "id"))!,
                                 not_ad: rs.string(forColumn: "notad")!)
                liste.append(not) //gelen değerleri listeye aktarmak
            }
            notlarListesi.onNext(liste) //gelen değerleri arayüzde Tetikleme işlemi
        }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func notlariYukle(){
        
        db?.open()
         var liste = [Notlar]() //db den gelecek nesneler için array oluşturmak
        do{
            let rs = try db!.executeQuery("select * from notlar", values: nil) //Bir kere çalışacak sorguyla notlar gelecek
            
            while rs.next(){
                //Gelecek değerleri arayüze basmak
                let not = Notlar(not_id: Int(rs.string(forColumn: "id"))!,
                                 not_ad: rs.string(forColumn: "notad")!)
                liste.append(not) //gelen değerleri listeye aktarmak
            }
            notlarListesi.onNext(liste) //gelen değerleri arayüzde Tetikleme işlemi
        }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
       
    }
}
