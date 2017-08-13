//
//  BLEService.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 1/12/16.
//  Copyright © 2016 ShangWang. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLEService{
    
    var centralManager: CBCentralManager!
    var bleHandler: BLEHandler
    
    init(){
        self.bleHandler = BLEHandler()
        self.centralManager = CBCentralManager(delegate: self.bleHandler, queue: nil)
    }
}
