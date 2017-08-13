//
//  BabyProfile+CoreDataProperties.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 12/25/15.
//  Copyright © 2015 ShangWang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

@objc class BabyProfileDB: NSManagedObject {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var picture: Data?
    @NSManaged var sensorID: String?

}
