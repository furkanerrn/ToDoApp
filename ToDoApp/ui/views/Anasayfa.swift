import RxSwift
import UIKit

class Anasayfa: UIViewController  {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var notlarTableView: UITableView!
    
    var notlarListesi = [Notlar]() // not nesnelerini diziye atmak
    var viewmodel = anasayfaViewModel()
    
   
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay"{
            if let not = sender! as? Notlar{
                let gidilecekVC = segue.destination as!  NotDetayVC
                gidilecekVC.not = not
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        viewmodel.notlariYukle()
        notlarTableView.delegate = self
        notlarTableView.dataSource = self 
        
        //Arayüzde veri getirmek
        _ = viewmodel.notlarListesi.subscribe(onNext: { liste in
            self.notlarListesi = liste
            self.notlarTableView.reloadData()
        })
        let apperance = UINavigationBarAppearance()
        apperance.backgroundColor = UIColor(named: "anaRenk")
        navigationController?.navigationBar.barStyle = .black
//        Farklı görünümlü apple ürünleri için appereance lar
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.compactAppearance = apperance
        navigationController?.navigationBar.scrollEdgeAppearance = apperance
         
    }
    override func viewWillAppear(_ animated: Bool) {
        viewmodel.notlariYukle() 
    }

}

extension Anasayfa : UISearchBarDelegate{
//    Arama yapma
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewmodel.ara(arananKelime: searchText)
    }
}

extension Anasayfa : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notlarListesi.count // notlar listesinin uzunluğu kadar değer getirmek
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let not = notlarListesi[indexPath.row]
//        değerlerin gideceği hücreyi tanımlamak
        let hucre = tableView.dequeueReusableCell(withIdentifier: "notlarHucre") as! notlarHucre
        
        hucre.labelNot.text = not.not_ad
        return hucre
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let not = notlarListesi[indexPath.row]
//        Seçilen değerleri detay sayfasına yollamak
        performSegue(withIdentifier: "toDetay", sender: not )
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){contextualAction,view,bool in
            let not = self.notlarListesi[indexPath.row ]
            let alert = UIAlertController(title: "Silme İşlemi", message: "Silmek istiyor musun?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title:"İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title:"Evet", style: .destructive){action in
                self.viewmodel.sil(not_id: not.not_id!)
            }
            alert.addAction(evetAction )
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction ])
    }
}

