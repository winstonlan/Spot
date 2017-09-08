//
//  CustomTableViewCell.swift
//  Spot
//
//  Created by William Khaine on 09/05/17.
//  Copyright © 2017 winstonlan. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var personsName: UILabel!
    @IBOutlet weak var personsPhoto: UIImageView!
    @IBOutlet weak var amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    /// Convert a price to a string
    func string(_ prefix: String, for cents: Int) -> String {
        return prefix + String(format: "2.2f", cents / 100)
    }
}
