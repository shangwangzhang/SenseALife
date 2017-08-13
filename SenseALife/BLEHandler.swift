//
//  BLEHandler.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 1/12/16.
//  Copyright © 2016 ShangWang. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLEHandler: NSObject, CBCentralManagerDelegate{
    override init(){
        super.init()
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        switch(central.state){
            case .unsupported:
                print("BLE is unsuported")
        case .poweredOn:
                central.scanForPeripherals(withServices: nil, options: nil)
            default:
                print("BLE default.")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("\(peripheral.name) : \(RSSI) dBm")
    }
}
