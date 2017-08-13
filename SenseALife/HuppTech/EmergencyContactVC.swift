//
//  EmergencyContactVC.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 26/06/17.
//  Copyright © 2017 ShangWang. All rights reserved.
//

import UIKit

class EmergencyContactVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var mainImageHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.leftGes))
        leftGesture.direction = .right
        self.view.addGestureRecognizer(leftGesture)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 15
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmergContCell") as! EmergContCell
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func leftGes()
    {
        self.navigationController?.popViewController(animated: true)
    }
}
