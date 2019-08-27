//
//  ATMsCell.swift
//  City ATMs
//
//  Created by admin on 8/19/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit

protocol ATMsCellDelegate {
    func toFavouriteList(index: Int)
}

class ATMsCell: UITableViewCell {
    
    @IBOutlet weak var fullAddressLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var addFavoritesButton: UIButton!
    @IBOutlet weak var blockButtonView: UIView!
    
    
    var delegate: ATMsCellDelegate?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(type: ATMModel) {
        fullAddressLabel.text = type.fullAddress
        placeLabel.text = type.place
    }
    
    @IBAction func didTapAddToFavourite(_ sender: Any) {
        addFavoritesButton.setTitle("✔️", for: .normal)
        blockButtonView.isHidden = false
        delegate?.toFavouriteList(index: index!)
    }
}
