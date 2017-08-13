//
//  TaskVC.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 26/06/17.
//  Copyright © 2017 ShangWang. All rights reserved.
//

import UIKit

class TaskVC: UIViewController {

    
    @IBOutlet weak var btn_pumpGas: UIButton!
    @IBOutlet weak var btn_loadGroceries: UIButton!
    @IBOutlet var mainImageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btn_pumpGas.layer.cornerRadius = 25.0
        self.btn_pumpGas.clipsToBounds = true
        
        self.btn_loadGroceries.layer.cornerRadius = 25.0
        self.btn_loadGroceries.clipsToBounds = true
        
        
        self.navigationController?.navigationBar.isHidden = false
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.leftGes))
        leftGesture.direction = .right
        self.view.addGestureRecognizer(leftGesture)
        
        
        if self.view.frame.size.height > 568
        {
            self.stackViewHeight.constant = 200
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func leftGes()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
