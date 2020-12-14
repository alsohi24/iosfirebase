//
//  AdminViewController.swift
//  proydamii
//
//  Created by Alvaro Soto on 12/13/20.
//

import UIKit
import FirebaseFirestore


class AdminViewController: UIViewController {

    let db = Firestore.firestore()
    var news: [Noticia] = []
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var btnAgregar:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 150
        self.btnAgregar.layer.cornerRadius = 7
        self.tableView.layer.cornerRadius = 10.0

        //self.tableView.didSelectRowAtIndexPath
//        self.tableView.estimatedRowHeight = 60
        self.lstNoticias()
        
        refreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "refrescando...")
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
            tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: Any) {
        self.lstNoticias()

    }
    
    func lstNoticias(){
        self.db.collection("noticias")
            .getDocuments { (documents, error) in
                self.news = []

                if error == nil && documents != nil{

                    for doc in documents!.documents{
                        let documentData = doc.data()
                        print(documentData)
                        let n = Noticia(id: doc.documentID ,titulo: documentData["titulo"] as! String, imagen: documentData["imagen"] as! String, cuerpo: documentData["cuerpo"] as! String,resumen: documentData["resumen"] as! String)
                        
                        self.news.append(n)
                        //self.refreshControl.endRefreshing()
                        self.tableView.reloadData()
                        
                    }
                }else{
                    //self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                    print("err en la llamada \(error)")
                }
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()

            }
    }
}


extension AdminViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! NoticiasTableViewCell
        cell.titulo.text = String(self.news[indexPath.row].titulo)
        cell.resumen.text = self.news[indexPath.row].resumen
       
        let url = URL(string: self.news[indexPath.row].imagen)
        let url2 = URL(string: "https://previews.123rf.com/images/manopjk/manopjk1711/manopjk171100023/90019226-illustrator-of-oops-404-error-page-not-found-vector-background.jpg")
        
        if(self.verifyUrl(urlString: self.news[indexPath.row].imagen)){
            try DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    cell.imagen.image = UIImage(data: data!)
                }
            }
        }else{
            DispatchQueue.global().async {
                let data2 = try? Data(contentsOf: url2!)
                DispatchQueue.main.async {
                    cell.imagen.image = UIImage(data: data2!)
                }
            }
        }


        self.tableView.deselectRow(at: indexPath, animated: true)
        
        return cell

    }
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: IndexPath!) {

        // Get Cell Label
        //let indexPath = tableView.indexPathForSelectedRow!
        //let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        //index= indexPath.row
        performSegue(withIdentifier: "goDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetail" {
            if segue.destination.isKind(of: NoticiaDetailViewController.self) {
                let secondVC = segue.destination as! NoticiaDetailViewController
                let path = self.tableView.indexPathForSelectedRow

                if(self.news.count > 0){
                    secondVC.tituloo = self.news[path!.row].titulo
                    secondVC.cuerpoo = self.news[path!.row].cuerpo
                    secondVC.imagenn = self.news[path!.row].imagen
                    secondVC.id = self.news[path!.row].id
                    secondVC.resumenn = self.news[path!.row].resumen
                }
            }
        }
    }
    
}
