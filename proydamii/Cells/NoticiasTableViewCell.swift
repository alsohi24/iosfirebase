//
//  NoticiasTableViewCell.swift
//  proydamii
//
//  Created by Alvaro Soto on 12/13/20.
//

import UIKit

class NoticiasTableViewCell: UITableViewCell {

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    
    @IBOutlet weak var resumen: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
