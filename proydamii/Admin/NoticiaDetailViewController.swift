//
//  NoticiaDetailViewController.swift
//  proydamii
//
//  Created by Alvaro Soto on 12/13/20.
//

import UIKit
import FirebaseFirestore

class NoticiaDetailViewController: UIViewController {
    
    var tituloo: String = ""
    var cuerpoo: String = ""
    var resumenn: String = ""
    var imagenn: String = ""
    var id: String = ""
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var btnEli: UIButton!
    @IBOutlet weak var titulo: UILabel!
    
    @IBOutlet weak var imagen: UIImageView!
    
    @IBOutlet weak var Cuerpo: UITextView!
    let db = Firestore.firestore()
  
    @IBAction func eliminarNoticia(_ sender: UIButton) {
        if self.id.isEmpty {
            self.alertFunc(msg:"Falta datos para realizar operacion")
                return;
            }
        
        db.collection("noticias").document(self.id).delete() { err in
            if let err = err {
                self.alertFunc(msg: "Error removing document: \(err)")
            } else {
                self.alertFunc(msg: "Noticia Eliminada!")
                
            }
            

        }
    }
    
    @IBAction func editarNoticia(_ sender: UIButton) {
        let nvc = self.storyboard?.instantiateViewController(withIdentifier: "NoticiasViewController") as! NoticiasViewController
        nvc.tituloo = tituloo
        nvc.resumenn = resumenn
        nvc.imagenn = imagenn
        nvc.cuerpoo = cuerpoo
        nvc.id = id

        self.present(nvc, animated: false, completion: nil)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titulo.text = tituloo
        self.Cuerpo.text = self.cuerpoo
        btnEdit.layer.cornerRadius = 7
        btnEli.layer.cornerRadius = 7
        
        let url = URL(string: self.imagenn)
        let url2 = URL(string: "https://previews.123rf.com/images/manopjk/manopjk1711/manopjk171100023/90019226-illustrator-of-oops-404-error-page-not-found-vector-background.jpg")
        if(self.verifyUrl(urlString: self.imagenn)){
            try DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    self.imagen.image = UIImage(data: data!)
                }
            }
        }else{
            DispatchQueue.global().async {
                let data2 = try? Data(contentsOf: url2!)
                DispatchQueue.main.async {
                    self.imagen.image = UIImage(data: data2!)
                }
            }
        }
    }
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    func alertFunc(msg:String){
        let alertController = UIAlertController(title: "Aceptar", message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default,handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true , completion: nil )
    }
    
}
