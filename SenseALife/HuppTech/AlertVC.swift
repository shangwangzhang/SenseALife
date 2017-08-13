//
//  AlertVC.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 26/06/17.
//  Copyright © 2017 ShangWang. All rights reserved.
//

import UIKit

class AlertVC: UIViewController {

    @IBOutlet var lbl_alert: UILabel!
    @IBOutlet var mainImageHeight: NSLayoutConstraint!
    
    //@IBOutlet weak var childLableHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewHeight = self.view.frame.size.height
        print(" Height : \(viewHeight/2)")
        self.mainImageHeight.constant = (viewHeight / 2)
        
        self.lbl_alert.layer.cornerRadius = 10.0
        self.lbl_alert.clipsToBounds = true
        
        self.navigationController?.navigationBar.isHidden = true
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.leftGes))
        leftGesture.direction = .right
        self.view.addGestureRecognizer(leftGesture)
        
        if self.view.frame.size.height > 568
        {
            //self.childLableHeight.constant = 180 // 135 5s
            self.lbl_alert.font = self.lbl_alert.font.withSize(33)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
   
    func leftGes()
    {
        _ = self.navigationController?.popViewController(animated: true)
    }

    

}
