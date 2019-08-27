//
//  FavoriteCell.swift
//  City ATMs
//
//  Created by admin on 8/20/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var fullAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(type: ATMModel) {
        placeLabel.text = type.place
        fullAddressLabel.text = type.fullAddress
    }
    
}
