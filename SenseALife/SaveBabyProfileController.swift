//
//  SaveBabyProfileController.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 1/9/16.
//  Copyright © 2016 ShangWang. All rights reserved.
//

import UIKit

class SaveBabyProfileController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var SensoLabel: UILabel! //This is the sensor label
    @IBOutlet var SaveBabyProfile: UIButton! //This IBOutlet is a button which is used to trigger the save Baby Profile process when clicked.
    @IBOutlet var BabyProfileImageView: UIImageView! //This IBOutlet contains the image of the baby.
    @IBOutlet var SensorList: UIPickerView! //This IBOutlet contains a list of all the sensors that have not yet been bounded to a profile.
    @IBOutlet var FirstNameText: UITextField! //This IBOutlet is the text field where the user can enter a the baby's first name
    @IBOutlet var LastNameText: UITextField! //This IBOutlet is the text field where the user can enter the baby's last name.
    
    //This enumeration contains definitions for actions that can be performed
    internal enum ActionMethod {
        case add //Add a new baby profile
        case edit //Edit an existing baby profile
    }
    
    var imagePicker: UIImagePickerController!
    var Action: ActionMethod!
    var BabyProfileObject = BabyProfile()
    
    fileprivate var _babyProfileRepo: IBabyRepository = BabyRepository()
    fileprivate var _selectedSensor:String = ""
    
    let pickerData = ["123-456-789-000","123-456-789-100",
                      "123-456-789-110","123-456-789-111",
                      "123-456-789-112","123-456-789-122"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SensorList.layer.borderColor = UIColor.gray.cgColor
        SensorList.layer.borderWidth = 1
        
        SensorList.dataSource = self
        SensorList.delegate = self
        
        //The three lines of code below will set up a tap gesture on the UIImageView so that when the user
        //tap it, he/she will be presented with the camera to snap a picture.
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(SaveBabyProfileController.TakeBabyPhoto(_:)))
        BabyProfileImageView.isUserInteractionEnabled = true
        BabyProfileImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //This override function will get executed everytime the page is loaded regardless of whether the app was started or not.
    override func viewWillAppear(_ animated: Bool) {
        if(self.Action == ActionMethod.edit){
            self.SensorList.isHidden = true
            self.SensoLabel.isHidden = true
            self.BabyProfileImageView = UIImageView(image: UIImage(data: self.BabyProfileObject.Picture as Data))
            self.FirstNameText.text = self.BabyProfileObject.FirstName
            self.LastNameText.text = self.BabyProfileObject.LastName
        }else{
            self.SensorList.isHidden = false
            self.SensoLabel.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _selectedSensor = pickerData[row]
    }
    
    //This function is called upon the user tapping on the UIIMageView. The code will trigger the
    //image picker to appear.
    @IBAction func TakeBabyPhoto(_ sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    //This function is executed when the user has selected the "Keep Photo" option.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        BabyProfileImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    //We are going to override the method touchesBegan:withEvent: for the ViewController itself.  This is called when the view sees a touch event (as it begins, appropriately).  In it, we are simply going to tell our main view to end editing.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    //This function is designed in order to save the baby object into the local core data.
    @IBAction func SaveBabyProfile(_ sender: AnyObject) {
        do{
            let bp = BabyProfile()
            
            bp.FirstName = FirstNameText.text
            bp.LastName = LastNameText.text
            bp.Picture = UIImagePNGRepresentation(BabyProfileImageView.image!)!
            
            if(bp.ValidateModel()){
                
                if(self.Action == ActionMethod.edit){
                    bp.BabyProfileID = self.BabyProfileObject.BabyProfileID
                    bp.SensorID = self.BabyProfileObject.SensorID
                    try _babyProfileRepo.EditBabyProfile(bp)
                    
                    self.DisplayAlert("", message: try _babyProfileRepo.GetVerbiage("SaveBabyProfile-SuccessfulySave"), callBackFunction: SegueToBabyProfileView)
                    
                }else{
                    bp.BabyProfileID =  UUID().uuidString
                    bp.SensorID = _selectedSensor
                    try _babyProfileRepo.SaveBabyProfile(bp)
                    
                    self.DisplayAlert("", message: try _babyProfileRepo.GetVerbiage("SaveBabyProfile-SuccessfulySave"), callBackFunction: SegueToBabyProfileView)
                }
            }else{
                self.DisplayAlert("", message: try _babyProfileRepo.GetVerbiage("SaveBabyProfile-InvalidModel"), callBackFunction: nil)
            }
            
        }catch{
            fatalError("Failed to save baby profile to the database located on the phone. Error: \(error)")
        }
    }
    
    //This function is designed in order to display the alert window
    fileprivate func DisplayAlert(_ alertHeader:String, message:String, callBackFunction: (() -> Void)!){
            
        let alert = UIAlertController(title: alertHeader, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "ok", style: UIAlertActionStyle.default) {  UIAlertAction in
            if(callBackFunction != nil){
                callBackFunction()
            }
        }
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //This function is designed in order to segue the user to the BabyProfile View
    fileprivate func SegueToBabyProfileView(){
        
        performSegue(withIdentifier: "ViewBabyProfilesSegue", sender: nil)
        
    }
}
