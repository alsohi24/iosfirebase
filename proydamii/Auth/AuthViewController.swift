//
//  ViewController.swift
//  FireBaseTutorialM
//
//  Created by jaime on 10/14/20.
//  Copyright © 2020 jaime. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth

class AuthViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var logInButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logInButton.layer.cornerRadius = 5
        title = "Autenticacion"
        
        Analytics.logEvent("InitScreen", parameters: ["message": "Integración de Firebase Completa"])
        
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String,
           let provider = defaults.value(forKey: "provider") as? String{
            	
            navigationController?.pushViewController(HomeViewController(email: email, name:"Cinéfilo"), animated: false)
        }
    }
    
    
    
    @IBAction func signInButtonAction(_ sender: Any) {

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "View2Controller") as? View2Controller
        let vc2 = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        
        let vc3 = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "View2Controller") as! View2Controller
        //HomeViewController(email: email, name:"Cinéfilo")
        vc3?.email = "amai@kaka.com"
        vc3?.name = "nameee"
        //ViewController SignUpViewController
        self.navigationController?.pushViewController(vc2!, animated: true)
        print("button sign up wprks!")
        
    }
    
    
    
    
    @IBAction func logInButtonAction(_ sender: Any) {
        
        if let email = emailTextField.text , let password = passwordTextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                //result.user
                //let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
                let defaults = UserDefaults.standard

                if let result = result , error == nil {
                    print(result.user.uid)
                    defaults.set(result.user.uid, forKey: "uid_id")
                    defaults.set(result.user.displayName, forKey: "nombreCompleto")
                    //defaults.set(self.email.text, forKey: "email")
//                    self.navigationController?
//                        .pushViewController(HomeViewController(email: result.user.email!, name: result.user.displayName ?? ""), animated: true)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                    //let resultViewController = storyBoard.instantiateViewController(withIdentifier: "View2Controller") as! View2Controller
//                    self.navigationController?
//                        .pushViewController(resultViewController, animated: true)
                   
                    if(4>1){
                        let tabbar2: UITabBarController? = (storyBoard.instantiateViewController(withIdentifier: "tabbaradmin") as? UITabBarController)
                        self.navigationController?.pushViewController(tabbar2!, animated: true)
                        
                    }else{
                        let tabbar: UITabBarController? = (storyBoard.instantiateViewController(withIdentifier: "tabbar") as? UITabBarController)
                        self.navigationController?.pushViewController(tabbar!, animated: true)
                        
                    }
                }else{
//                    let alertController = UIAlertController(title: "Aceptar", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
//                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
//                    self.present(alertController, animated: true , completion: nil )
                    self.alertFunc(msg:"Se ha producido un error registrando el usuario")
                }
            }
        }     
    }
    
    func alertFunc(msg:String){
        let alertController = UIAlertController(title: "Aceptar", message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true , completion: nil )
    }


}

