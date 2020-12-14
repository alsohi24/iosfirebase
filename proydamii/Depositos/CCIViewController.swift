//
//  CCIViewController.swift
//  proydamii
//
//  Created by Adrian Soto on 12/13/20.
//

import UIKit
import FirebaseFirestore

class CCIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnEfectuar.layer.cornerRadius = 5
    }
    @IBOutlet weak var cci: UITextField!
    
    @IBOutlet weak var btnEfectuar: UIButton!
    
    @IBOutlet weak var monto: UITextField!
    let db = Firestore.firestore()
  

    @IBAction func efectuarDeposito(_ sender: UIButton) {
        self.btnEfectuar.layer.cornerRadius = 5
        let uid_ = UserDefaults.standard.string(forKey: "uid_id")
        let name = UserDefaults.standard.string(forKey: "nombreCompleto")
        
        self.db.collection("tranferencias").document().setData([
            "uid_id_ejecutante": uid_,
            "ejecutante": name,
            "destino": self.cci.text,
            "monto": self.monto.text,
            
        ]) { [self] err in
            if let err = err {
                self.alertFunc(msg:"Error writing document: \(err)")
                print("Error writing document: \(err)")
            } else {
                self.alertFunc(msg:"Transaccion realizada con exito!")
                print("Document successfully written!")
            }
        }
    }
    
    func alertFunc(msg:String){
        let alertController = UIAlertController(title: "Aceptar", message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true , completion: nil )
    }
    
}
