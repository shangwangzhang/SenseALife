//
//  BabyVC.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 24/06/17.
//  Copyright © 2017 ShangWang. All rights reserved.
//

import UIKit

class BabyVC: UIViewController {

    @IBOutlet var btn_temp: UIButton!
    @IBOutlet var btn_emerg: UIButton!
    @IBOutlet var btn_timer: UIButton!
    @IBOutlet var mainImageHeight: NSLayoutConstraint!
    @IBOutlet var buttonsStackView: UIStackView!
    
    
    
    @IBOutlet var mySwitch: UISwitch!
    @IBOutlet weak var lbl_deviceStatus: UILabel!
    
    @IBOutlet weak var stackViewBottomLayout: NSLayoutConstraint!
    
    @IBOutlet var lastButtonHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewHeight = self.view.frame.size.height
        
        self.navigationController?.navigationBar.isHidden = false
      
        self.buttonsStackView.isHidden = true
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.leftGes))
        leftGesture.direction = .right
        self.view.addGestureRecognizer(leftGesture)
        
        self.mainImageHeight.constant = (viewHeight / 2)
        
        if self.view.frame.size.height >= 568
        {
            self.mainImageHeight.constant = (viewHeight / 2) - 30
            self.lbl_deviceStatus.font = self.lbl_deviceStatus.font.withSize(16)
        }
        else
        {
            //self.btn_temp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 55)
        }
        
        self.mySwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
        
        print(self.mainImageHeight.constant)
        print("bH : \(self.btn_temp.frame.size.height)")
        //let btnHeight = self.btn_temp.frame.size.height
        
        //self.btn_temp.layer.cornerRadius = btnHeight / 2
        //self.btn_temp.clipsToBounds = true
        
    
        print("Button Height : \(self.btn_temp.frame.size.height)")
    }
    
   // override func viewWillAppear(_ animated: Bool) {
     //   super.viewWillAppear(animated)
        
        
    //}
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if self.view.frame.size.height > 568
        {
            self.btn_temp.titleLabel?.font = self.btn_temp.titleLabel?.font.withSize(22)
            self.btn_emerg.titleLabel?.font = self.btn_emerg.titleLabel?.font.withSize(22)
            self.btn_timer.titleLabel?.font = self.btn_timer.titleLabel?.font.withSize(22)
            //self.stackViewBottomLayout.constant = 50
            
            self.btn_temp.layer.cornerRadius = self.btn_temp.frame.size.height / 2.0
            self.btn_temp.clipsToBounds = true
            self.btn_emerg.layer.cornerRadius = self.btn_temp.frame.size.height / 2.0
            self.btn_emerg.clipsToBounds = true
            self.btn_timer.layer.cornerRadius = self.btn_temp.frame.size.height / 2.0
            self.btn_timer.clipsToBounds = true
            
            self.lbl_deviceStatus.font = self.lbl_deviceStatus.font.withSize(20)
        }
        else
        {
            self.btn_temp.layer.cornerRadius = 20.0 // self.btn_temp.frame.size.height / 2.0
            self.btn_temp.clipsToBounds = true
            self.btn_emerg.layer.cornerRadius = 20.0 // self.btn_temp.frame.size.height / 2.0
            self.btn_emerg.clipsToBounds = true
            self.btn_timer.layer.cornerRadius = 20.0 // self.btn_temp.frame.size.height / 2.0
            self.btn_timer.clipsToBounds = true
        }
        
        UIView.animate(withDuration: 0.3) { 
            
            self.buttonsStackView.isHidden = false
            
        }
        
    }

    func leftGes()
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    

}
