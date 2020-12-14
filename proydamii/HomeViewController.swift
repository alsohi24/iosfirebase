//
//  HomeViewController.swift
//  proydamii
//
//  Created by eknowit on 12/12/20.
//

import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController {

    public var email: String = ""
    public var name: String = ""
    let db = Firestore.firestore()
    var trans: [Transferencia] = []
    
    @IBOutlet weak var btnTranferir: UIButton!
    @IBOutlet weak var tableView: UITableView!
    init(email: String,  name: String) {
        self.email = email
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnTranferir.layer.cornerRadius = 5
        self.tableView.layer.cornerRadius = 10

        let uid_:String = UserDefaults.standard.string(forKey: "uid_id")!

        self.db.collection("tranferencias")
            .whereField("uid_id_ejecutante", isEqualTo: uid_)
            .getDocuments { (documents, error) in
                if error == nil && documents != nil{
                    for doc in documents!.documents{
                        let documentData = doc.data()
                        print(documentData)
                        let trans = Transferencia(monto: Int(documentData["monto"] as! String) ?? 0, destino: documentData["destino"] as! String)
                        
                        self.trans.append(trans)
                        self.tableView.reloadData()
                    }
                }else{
                    print("err en la llamada \(error)")
                }
            }
        print(self.email)
        print(self.name)
        // Do any additional setup after loading the view.
    }
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! transTableViewCell
        //cell.monto.text = "4000"
        
        cell.monto.text = String(self.trans[indexPath.row].monto)
        cell.cuentaDestino.text = self.trans[indexPath.row].destino
        //cell.cuentaDestino.text = "32r23r32e"
//        if(self.provider == "Cinéfilo"){
//            (cell as! cell1TableViewCell).title.text = self.movieData[indexPath.row].title
//            (cell as! cell1TableViewCell).desc.text = self.movieData[indexPath.row].desc
//            (cell as! cell1TableViewCell).rating.text = self.movieData[indexPath.row].val
//            if let url = URL(string: self.movieData[indexPath.row].image) {
//                    if let data = try? Data(contentsOf: url) {
//                        (cell as! cell1TableViewCell).img.image = UIImage(data: data)
//                    }
//               }
//        }else{
//            (cell as! cell2TableViewCell).title.text = self.movieData[indexPath.row].title
//            (cell as! cell2TableViewCell).desc.text = self.movieData[indexPath.row].desc
//            (cell as! cell2TableViewCell).season.text = self.movieData[indexPath.row].season
//            if let url = URL(string: self.movieData[indexPath.row].image) {
//                    if let data = try? Data(contentsOf: url) {
//                        (cell as! cell2TableViewCell).img.image = UIImage(data: data)
//                    }
//               }
//        }
//       let c = cell
        return cell

    }
    
    
    
}
