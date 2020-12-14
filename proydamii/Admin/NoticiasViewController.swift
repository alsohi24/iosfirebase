//
//  NoticiasViewController.swift
//  proydamii
//
//  Created by Alvaro Soto on 12/13/20.
//

import UIKit
import FirebaseFirestore

class NoticiasViewController: UIViewController {

    @IBOutlet weak var titulo: UITextField!
    @IBOutlet weak var resumen: UITextField!
    
    @IBOutlet weak var cuerpo: UITextView!
    @IBOutlet weak var imagen: UITextField!
    
    @IBOutlet weak var btnAction: UIButton!
    var tituloo: String = ""
    var cuerpoo: String = ""
    var resumenn: String = ""
    var imagenn: String = ""
    var id: String = ""
    
    let db = Firestore.firestore()
    let uid_ = UserDefaults.standard.string(forKey: "uid_id")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnAction.layer.cornerRadius = 8
        
        self.settData()

    }
    
    @IBAction func addNoticia(_ sender: UIButton) {
        
        if !self.id.isEmpty{
            self.editarNoticia()
        }else{
            self.agregarNoticia()
        }
    }
    func settData(){
        if !self.id.isEmpty{
            self.titulo.text = tituloo
            self.resumen.text = resumenn
            self.cuerpo.text = cuerpoo
            self.imagen.text = imagenn
            self.btnAction.setTitle("Editar", for: .normal)
            self.btnAction.backgroundColor = UIColor.systemBlue
            

        }else{
            self.btnAction.setTitle("Agregar", for: .normal)
            self.btnAction.backgroundColor = UIColor.green

        }
    }
    
    func editarNoticia(){
            if self.titulo.text?.isEmpty ?? true {
                self.alertFunc(msg:"Campo titulo vacio")
                    return;
                }
            if self.resumen.text?.isEmpty ?? true {
                self.alertFunc(msg:"Campo resumen vacio")
                    return;
                }
            if self.resumen.text?.isEmpty ?? true {
                self.alertFunc(msg:"Campo resumen vacio")
                    return;
                }
            if(!self.verifyUrl(urlString: self.imagen.text)){
                self.alertFunc(msg:"Ingrese una imagen valida")
                return;
            }
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            
                self.db.collection("noticias").document(self.id).setData([
                    "titulo": self.titulo.text,
                    "resumen": self.resumen.text,
                    "cuerpo": self.cuerpo.text,
                    "imagen": self.imagen.text,
                    "editor_noticia": self.uid_,
                    "fecha_edicion": formatter.string(from: date),
                ], merge: true) { [self] err in
                    if let err = err {
                       
                        self.alertFunc(msg:"Error writing document: \(err)")
                        
                        print("Error writing document: \(err)")
                    } else {
                        
                        self.alertFunc(msg:"Noticia editada")
                        //dismiss(animated: true, completion: nil)
                        print("Noticia editada")
                    }
                }
        
    }
    func agregarNoticia(){

        if self.titulo.text?.isEmpty ?? true {
            self.alertFunc(msg:"Campo titulo vacio")
                return;
            }
        if self.resumen.text?.isEmpty ?? true {
            self.alertFunc(msg:"Campo resumen vacio")
                return;
            }
        if self.resumen.text?.isEmpty ?? true {
            self.alertFunc(msg:"Campo resumen vacio")
                return;
            }
        if(!self.verifyUrl(urlString: self.imagen.text)){
            self.alertFunc(msg:"Ingrese una imagen valida")
            return;
        }
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        
            self.db.collection("noticias").document().setData([
                "titulo": self.titulo.text,
                "resumen": self.resumen.text,
                "cuerpo": self.cuerpo.text,
                "imagen": self.imagen.text,
                "creador_noticia": self.uid_,
                "fecha_creacion": formatter.string(from: date)
            ]) { [self] err in
                if let err = err {
                   
                    self.alertFunc(msg:"Error writing document: \(err)")
                    
                    print("Error writing document: \(err)")
                } else {
                    
                    self.alertFunc(msg:"Noticia agregada!")
                    //dismiss(animated: true, completion: nil)
                    print("Document successfully written!")
                }
            }
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                if(UIApplication.shared.canOpenURL(url as URL)){
                    return urlString.isImage()
                }
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

extension String {

    public func isImage() -> Bool {
        // Add here your image formats.
        let imageFormats = ["jpg", "jpeg", "png", "gif"]

        if let ext = self.getExtension() {
            return imageFormats.contains(ext)
        }

        return false
    }
    
    public func getExtension() -> String? {
           let ext = (self as NSString).pathExtension

           if ext.isEmpty {
               return nil
           }

           return ext
        }
}
