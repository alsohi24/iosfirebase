//
//  transTableViewCell.swift
//  proydamii
//
//  Created by Adrian Soto on 12/13/20.
//

import UIKit

class transTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var monto: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var cuentaDestino: UILabel!
    
}
