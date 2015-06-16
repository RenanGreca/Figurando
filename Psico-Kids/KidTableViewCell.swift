//
//  KidTableViewCell.swift
//  Psico-Kids
//
//  Created by Samuel Lucas Ribeiro Cortez on 15/06/15.
//  Copyright (c) 2015 br.pucpr.bepid. All rights reserved.
//

import UIKit

class KidTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var kidsName: UILabel!
    @IBOutlet weak var kidsAge: UILabel!
    @IBOutlet weak var parentsContact: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
