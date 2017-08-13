//
//  ChildSecuredVC.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 24/06/17.
//  Copyright © 2017 ShangWang. All rights reserved.
//

import UIKit

class ChildSecuredVC: UIViewController {

    @IBOutlet var lbl_AlertMsg:UILabel!
    @IBOutlet var lbl_childSecured: UILabel!
    @IBOutlet var mainImageHeight: NSLayoutConstraint!
    var alertFlag = false
    //@IBOutlet weak var childLableHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewHeight = self.view.frame.size.height
        print(" Height : \(viewHeight/2)")
        self.mainImageHeight.constant = (viewHeight / 2)
        
        self.lbl_childSecured.layer.cornerRadius = 10.0
        self.lbl_childSecured.clipsToBounds = true
        
        
        self.navigationController?.navigationBar.isHidden = false
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.leftGes))
        leftGesture.direction = .right
        self.view.addGestureRecognizer(leftGesture)
        
        let myTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.alertBtn))
        myTapGesture.numberOfTapsRequired = 1
        self.lbl_childSecured.addGestureRecognizer(myTapGesture)
        self.lbl_childSecured.isUserInteractionEnabled = true
        if self.view.frame.size.height > 568
        {
            //self.childLableHeight.constant = 180 // 135 5s
            self.lbl_childSecured.font = self.lbl_childSecured.font.withSize(33)
            
        }
        
        lbl_AlertMsg.text = "Your child is still in the car!"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.view.frame.size.height > 568
        {
            //self.childLableHeight.constant = 180 // 135 5s
            self.lbl_childSecured.font = self.lbl_childSecured.font.withSize(33)
            
        }
    }

    func leftGes()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func alertBtn() {
        
        if alertFlag{
            lbl_AlertMsg.text = "Your child is still in the car!"
            self.lbl_childSecured.text = "Child Secured"
            self.lbl_childSecured.backgroundColor = UIColor(red:0.45, green:0.82, blue:0.52, alpha:1.0)
            alertFlag = false
        }
        else{
            lbl_AlertMsg.text = "Your child is not in the car!"
            self.lbl_childSecured.text = "Alert"
            self.lbl_childSecured.backgroundColor = UIColor(red:0.53, green:0.15, blue:0.40, alpha:1.0)
            alertFlag = true

        }
    }
}
