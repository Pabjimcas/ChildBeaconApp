//
//  BeaconTableViewCell.swift
//  ChildBeaconProject
//
//  Created by mikel balduciel diaz on 17/3/16.
//  Copyright © 2016 mikel balduciel diaz. All rights reserved.
//

import UIKit

class BeaconTableViewCell: UITableViewCell {

    @IBOutlet weak var nameBeaconLabel: UILabel!
    @IBOutlet weak var uuidBeaconLabel: UILabel!
    @IBOutlet weak var editBt: UIButton!
    @IBOutlet weak var deleteBt: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
