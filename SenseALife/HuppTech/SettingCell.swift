//
//  SettingCell.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 03/07/17.
//  Copyright © 2017 ShangWang. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    
    @IBOutlet var img_icon: UIImageView!
    @IBOutlet var lbl_title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img_icon.layer.cornerRadius = 10.0
        img_icon.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
