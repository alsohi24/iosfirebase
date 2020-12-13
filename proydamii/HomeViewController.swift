//
//  HomeViewController.swift
//  proydamii
//
//  Created by eknowit on 12/12/20.
//

import UIKit

class HomeViewController: UIViewController {

    public var email: String = ""
    public var name: String = ""
    
    
     init(email: String,  name: String) {
        self.email = email
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)

    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.email)
        print(self.name)
        // Do any additional setup after loading the view.
    }
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! transTableViewCell
        //cell.monto.text = "4000"
        cell.monto.text = "www"
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
