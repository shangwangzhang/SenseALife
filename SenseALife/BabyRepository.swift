//
//  BabyRepository.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 12/25/15.
//  Copyright © 2015 ShangWang. All rights reserved.
//
import CoreData
import Foundation
import UIKit

open class BabyRepository: IBabyRepository{
    
    //This function is designed in order to edit an existing baby profile.
    func EditBabyProfile(_ babyProfile:BabyProfile) throws -> Bool {
        var updated: Bool = false
        
        /*do {
            let moc = CoreDataService().managedObjectContext
            
             let fetchRequest = NSFetchRequest(entityName: "BabyProfile")
             fetchRequest.predicate = NSPredicate(format: "babyProfileID = %@", babyProfile.BabyProfileID!)
            
            if let fetchedBabyProfiles = try moc.fetch(fetchRequest) as? [NSManagedObject] {
                if fetchedBabyProfiles.count != 0{
                    
                    var managedObject = fetchedBabyProfiles[0]
                    managedObject.setValue(babyProfile.FirstName, forKey: "firstName")
                    managedObject.setValue(babyProfile.LastName, forKey: "lastName")
                    managedObject.setValue(babyProfile.Picture, forKey: "picture")
                    managedObject.setValue(babyProfile.SensorID, forKey: "sensorID")
                    
                    try moc.save()
                
                    updated = true
                }
            }
        } catch {
            fatalError("Failed to edit the baby profile in the database on the phone. Error: \(error)")
        }
        */
        return updated
    }
    
    //This repository function is designed in order to save a baby's profile into the
    //local database. The function accepts a Baby object which contains the baby's first
    //and last name as well as the baby's picture and the device that is binded to the app
    //which belongs to the respective baby's carseat.
    func SaveBabyProfile(_ babyProfile:BabyProfile) throws {
        // we save our entity
        do {
            // create an instance of our managedObjectContext
            let moc = CoreDataService().managedObjectContext
            
            // we set up our entity by selecting the entity and context that we're targeting
            let entity = NSEntityDescription.insertNewObject(forEntityName: "BabyProfile", into: moc)
            
            // Add the data to the managed object context
            entity.setValue(babyProfile.BabyProfileID, forKey: "babyProfileID")
            entity.setValue(babyProfile.FirstName, forKey: "firstName")
            entity.setValue(babyProfile.LastName, forKey: "lastName")
            entity.setValue(babyProfile.Picture, forKey: "picture")
            entity.setValue(babyProfile.SensorID, forKey: "sensorID")
        
            // Attempt to save the data to the database
            try moc.save()
            
        } catch {
            fatalError("Failed to save the baby profile in the database on the phone. Error: \(error)")
        }
    }
    
    //This repository function is designed in order to retrieve all of the baby profiles from the database.
    //The funcion will return the result as a BabyProfile array.
    func FetchBabyProfiles() throws -> [BabyProfile]{
        
        let moc = CoreDataService().managedObjectContext
        // ==== let personFetch = NSFetchRequest(entityName: "BabyProfile")
        
        let babyProfile: BabyProfile = BabyProfile()
        
        // ==== let fetchedBabyProfiles: [AnyObject] = try moc.fetch(personFetch)
        
        // ==== return babyProfile.MapToList(fetchedBabyProfiles)
        return []
    }
    
    //This function is designed in order to return a specific message from the property list.
    func GetVerbiage(_ propertyName:String) throws -> String{
        
        var myDict: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "Verbiages", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        
        if let dict = myDict {
            return dict.object(forKey: propertyName) as! String
        }
        
        return ""
    }
}
