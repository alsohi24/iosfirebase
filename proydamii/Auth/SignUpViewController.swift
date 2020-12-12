//
//  SignInViewController.swift
//  FireBaseTutorialM
//
//  Created by eknowit on 11/21/20.
//  Copyright © 2020 jaime. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

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
                    //Auth.updateCurrentUser(<#T##self: Auth##Auth#>)
                    let changeRequest = user?.createProfileChangeRequest()
                    changeRequest?.displayName = self.tiposelect
                    changeRequest?.commitChanges { (error) in
                     print(error)
                    }
                    if let result = result , error == nil {
                        self.navigationController?
                            .pushViewController(HomeViewController(email: result.user.email!, name:self.tiposelect ), animated: true)
                    }else{
                        let alertController = UIAlertController(title: "Aceptar", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self.present(alertController, animated: true , completion: nil )
                    }
                }
            }
        }else{
            let alertController = UIAlertController(title: "Aceptar", message: "Las contraseñas no coinciden, intente de nuevo pls", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alertController, animated: true , completion: nil )
        }
           
    }
    

}
