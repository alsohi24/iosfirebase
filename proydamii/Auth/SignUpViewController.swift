//
//  SignInViewController.swift
//  FireBaseTutorialM
//
//  Created by eknowit on 11/21/20.
//  Copyright © 2020 jaime. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SignUpViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tpuser.count
    }
    var tiposelect: String = ""

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        tiposelect = tpuser[row]
            return tpuser[row]
        }
    
    @IBOutlet weak var btnSingin: UIButton!
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var paas2: UITextField!
    
    @IBOutlet weak var tipo: UIPickerView!
    var tpuser: [String] = [String]()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnSingin.layer.cornerRadius = 5
        tpuser = ["Cinéfilo", "Seriéfilo"]
        self.tipo.delegate = self
        self.tipo.dataSource = self
    }
    

    @IBAction func backToLogIn(_ sender: UIButton) {
        self.navigationController?
        .pushViewController(AuthViewController(), animated: true)
    }
    
    @IBAction func createUser(_ sender: UIButton) {
        if(self.password.text == self.paas2.text){
            if let email = email.text , let password = password.text {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    let user = Auth.auth().currentUser
                    let changeRequest = user?.createProfileChangeRequest()
                    changeRequest?.displayName = self.fullname.text
                    changeRequest?.commitChanges { (error) in
                        self.alertFunc(msg: "Error al comitear cambios")
                    print("+++++++++++ Comiteo de cambios +++++++++++")
                     print(error)
                    }
                    if let result = result , error == nil {
                        self.db.collection("usuarios").document().setData([
                            "nombreCompleto": self.fullname.text,
                            "email": self.email.text,
                            "tipo": self.tiposelect,
                            "uid_id": result.user.uid
                            
                        ]) { [self] err in
                            if let err = err {
                               
                                self.alertFunc(msg:"Error writing document: \(err)")
                                print("Error writing document: \(err)")
                            } else {
                                let defaults = UserDefaults.standard
                                //defaults.set(25, forKey: "Age")
                                defaults.set(result.user.uid, forKey: "uid_id")
                                defaults.set(self.fullname.text, forKey: "nombreCompleto")
                                defaults.set(self.email.text, forKey: "email")
                                defaults.set(self.tiposelect, forKey: "tipo")
                                self.alertFunc(msg:"Document successfully written!")
                                print("Document successfully written!")
                            }
                        }
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                        let tabbar: UITabBarController? = (storyBoard.instantiateViewController(withIdentifier: "tabbar") as? UITabBarController)
                        self.navigationController?.pushViewController(tabbar!, animated: true)

                    }else{
//                        let alertController = UIAlertController(title: "Aceptar", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
//                        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
//                        self.present(alertController, animated: true , completion: nil )
                        self.alertFunc(msg: "Se ha producido un error registrando el usuario")
                    }
                }
            }
        }else{
//            let alertController = UIAlertController(title: "Aceptar", message: "Las contraseñas no coinciden, intente de nuevo pls", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
//            self.present(alertController, animated: true , completion: nil )
            self.alertFunc(msg: "Las contraseñas no coinciden, intente de nuevo pls")
        }
           
    }
    
    func alertFunc(msg:String){
        let alertController = UIAlertController(title: "Aceptar", message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true , completion: nil )
    }

}
