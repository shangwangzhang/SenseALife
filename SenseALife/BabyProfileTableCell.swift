//
//  BabyProfileTableCell.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 12/27/15.
//  Copyright © 2015 ShangWang. All rights reserved.
//

import UIKit

class BabyProfileTableCell: UITableViewCell {
    
    @IBOutlet weak var BabyImage: UIImageView!
    @IBOutlet weak var FullName: UILabel!
    @IBOutlet weak var SensorID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
