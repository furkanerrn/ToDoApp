//
//  NotKayit.swift
//  ToDoApp
//
//  Created by Furkan Eren on 2.01.2024.
//

import UIKit

class NotKayitVC: UIViewController {
var viewModel = notKayitViewModel()
    
    
    @IBAction func buttonKaydet(_ sender: Any) {
        if let na = txtNotAd.text{
            viewModel.kaydet(not_ad: na)
        }
    }
   
    @IBOutlet weak var txtNotAd: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    }


