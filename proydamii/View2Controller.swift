//
//  View2Controller.swift
//  proydamii
//
//  Created by eknowit on 12/11/20.
//

import UIKit

class View2Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapButton(){
        //let vc  = UIViewController()
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController

        vc?.view.backgroundColor = .black
        navigationController?.pushViewController(vc!, animated: true)
    }
}
