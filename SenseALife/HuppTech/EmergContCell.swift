//
//  EmergContCell.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 26/06/17.
//  Copyright © 2017 ShangWang. All rights reserved.
//

import UIKit

class EmergContCell: UITableViewCell {

    
    @IBOutlet weak var img_contImage: UIImageView!
    
    @IBOutlet weak var lbl_name: UILabel!
    
    @IBOutlet weak var lbl_number: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img_contImage.layer.cornerRadius = 17.5
        img_contImage.clipsToBounds = true
        
    }

    

}
