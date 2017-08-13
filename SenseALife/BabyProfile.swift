//
//  Baby.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 12/25/15.
//  Copyright © 2015 ShangWang. All rights reserved.
//

import CoreData
import Foundation
import UIKit

open class BabyProfile{
    var BabyProfileID: String?
    var FirstName: String?
    var LastName: String?
    var Picture: Data
    var SensorID: String?
    
    init() {
        self.Picture = Data()
    }
    
    //This function is designed in order to validate the model (Baby Profile).
    //A true logic is returned if an only if conditions are not satisfied; otherwise,
    //if some or all conditions are met then the model is not considered valid.
    internal func ValidateModel() -> Bool{
        
        var valid: Bool = true
        
        if (self.FirstName?.isEmpty == true){
            valid = false
        }
        
        if (self.LastName?.isEmpty == true){
            valid = false
        }
        
        if (self.Picture.count == 0){
            valid = false
        }
        
        if (self.SensorID?.isEmpty == true){
            valid = false
        }
        
        return valid
    }
    
    //This function is designed in order to map a record returned from Data Core to a Baby Profile object.
    internal func Map(_ data:[AnyObject])-> BabyProfile{
        
        let babyProfile = BabyProfile()
        
        if(data.count > 0){
            
            babyProfile.BabyProfileID = data[0].value(forKey: "babyProfileID") as? String
            babyProfile.FirstName = data[0].value(forKey: "firstName") as? String
            babyProfile.LastName = data[0].value(forKey: "lastName") as? String
            
            if(data[0].value(forKey: "picture") == nil){
                //babyProfile.Picture  = UIImagePNGRepresentation(UIImage(imageLiteral: "DefaultBabyPicture.png"))!
            }else{
                babyProfile.Picture = (data[0].value(forKey: "picture") as? Data)!
            }
            babyProfile.SensorID = data[0].value(forKey: "sensorID") as? String
        }
        
        return babyProfile
    }
    
    //This function is designed in order to map the data returned from core data to a list of BabyProfile
    internal func MapToList(_ data:[AnyObject])->[BabyProfile]{
        var profiles = [BabyProfile]()
        var babyProfile: BabyProfile = BabyProfile()
        
        /*for i in 0..<data.count
        {
            babyProfile = BabyProfile()
            
            babyProfile.BabyProfileID = data[i].value(forKey: "babyProfileID") as? String
            babyProfile.FirstName = data[i].value(forKey: "firstName") as? String
            babyProfile.LastName = data[i].value(forKey: "lastName") as? String
            
            if(data[i].value(forKey: "picture") == nil){
                babyProfile.Picture  = UIImagePNGRepresentation(UIImage(imageLiteral: "DefaultBabyPicture.png"))!
            }else{
                babyProfile.Picture = (data[i].value(forKey: "picture") as? Data)!
            }
            babyProfile.SensorID = data[i].value(forKey: "sensorID") as? String
            
            if(babyProfile.FirstName == nil || babyProfile.LastName == nil){
                continue
            }
            
            profiles.append(babyProfile)
        }*/
        
        /*for(i in 0 ..< data.count){
            babyProfile = BabyProfile()
            
            babyProfile.BabyProfileID = data[i].value(forKey: "babyProfileID") as? String
            babyProfile.FirstName = data[i].value(forKey: "firstName") as? String
            babyProfile.LastName = data[i].value(forKey: "lastName") as? String
            
            if(data[i].value(forKey: "picture") == nil){
                babyProfile.Picture  = UIImagePNGRepresentation(UIImage(imageLiteral: "DefaultBabyPicture.png"))!
            }else{
                babyProfile.Picture = (data[i].value(forKey: "picture") as? Data)!
            }
            babyProfile.SensorID = data[i].value(forKey: "sensorID") as? String
            
            if(babyProfile.FirstName == nil || babyProfile.LastName == nil){
                continue
            }
            
            profiles.append(babyProfile)
        }*/
        
        return profiles
    }
}
