//
//  SettingsVC.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 26/06/17.
//  Copyright © 2017 ShangWang. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var tbl_tableView: UITableView!
    @IBOutlet var img_profileImage: UIImageView!
    
    
    var titleText = [String]()
    var imageArray = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleText = ["Baby", "Alert", "Emergency Contacts", "Pump Gas & Load Groceries"]
        self.imageArray = [#imageLiteral(resourceName: "Baby-grey"), #imageLiteral(resourceName: "alert"), #imageLiteral(resourceName: "message copy"), #imageLiteral(resourceName: "timer")]
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.leftGes))
        leftGesture.direction = .right
        self.view.addGestureRecognizer(leftGesture)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.tbl_tableView.tableFooterView = UIView(frame: .zero)
        
        self.img_profileImage.layer.cornerRadius = 60
        self.img_profileImage.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }

    func leftGes()
    {
        _ = self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titleText.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell

        cell.img_icon.image = self.imageArray[indexPath.row]
        cell.lbl_title.text = self.titleText[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0
        {
            let toBaby = self.storyboard?.instantiateViewController(withIdentifier: "BabyVC") as! BabyVC
            self.navigationController?.pushViewController(toBaby, animated: true)
        }
        
        if indexPath.row == 1
        {
            let toBaby = self.storyboard?.instantiateViewController(withIdentifier: "ChildSecuredVC") as! ChildSecuredVC
            self.navigationController?.pushViewController(toBaby, animated: true)
        }
        
//        if indexPath.row == 2
//        {
//            let toBaby = self.storyboard?.instantiateViewController(withIdentifier: "AlertVC") as! AlertVC
//            self.navigationController?.pushViewController(toBaby, animated: true)
//        }
        
        if indexPath.row == 2
        {
            let toBaby = self.storyboard?.instantiateViewController(withIdentifier: "EmergencyContactVC") as! EmergencyContactVC
            self.navigationController?.pushViewController(toBaby, animated: true)
        }
        
        if indexPath.row == 3
        {
            let toBaby = self.storyboard?.instantiateViewController(withIdentifier: "TaskVC") as! TaskVC
            self.navigationController?.pushViewController(toBaby, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0
        {
            return 44
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.tbl_tableView.frame.size.width, height: 44))
        headerView.backgroundColor = #colorLiteral(red: 0.9294120669, green: 0.9260692, blue: 0.9329036474, alpha: 1)
        
        let label = UILabel.init(frame: CGRect(x: 12, y: 8, width: 180, height: 40))
        label.backgroundColor = UIColor.clear
        label.text = "ACCOUNT"
        label.font = UIFont(name: "Avenir-Medium", size: 14)
        label.textColor = UIColor.darkGray
        headerView.addSubview(label)
        
        return headerView
    }
    
    
   

}
