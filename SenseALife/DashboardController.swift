//
//  FirstViewController.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 12/20/15.
//  Copyright © 2015 ShangWang. All rights reserved.
//

import UIKit
import CoreBluetooth

class DashboardController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate{
    
    @IBOutlet var alertLabel: UILabel!
    @IBOutlet var alertImage: UIImageView!
    @IBOutlet var Logger: UITextView! //This IBOutlet is designed in order to hold the logs for the
    @IBOutlet var gasStationImage: UIButton!


    
    //This variable contains the logic which indicates whether a notification has been triggered
    fileprivate var parentNotified: Bool = false
    
    //This variable contains the time of the notification when it was sent to the parents
    fileprivate var timeOfNotification: Date = Date()
    
    // BLE
    var centralManager : CBCentralManager!
    var SenseALifePeripheral : CBPeripheral!
    
    let DeviceName = "HMSoft" //This is the device name
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.applicationIconBadgeNumber = -1
        
        self.alertImage.isHidden = true
        self.alertLabel.isHidden = true
        
        centralManager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Check status of BLE hardware
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            // Scan for peripherals if BLE is turned on
            central.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
            //Logger.text = Logger.text + ("\nSearching for Sense-A-Life Device")
        }
        else {
            // Can have different conditions for all states if needed - print generic message for now
            //Logger.text = Logger.text + ("\nThe Sense-A-Life bluetooth switched off or not initialized")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        let nameOfDeviceFound = (advertisementData as NSDictionary).object(forKey: CBAdvertisementDataLocalNameKey) as? NSString
        
        if (nameOfDeviceFound == self.DeviceName as NSString) {
            // Update Status Label
            //Logger.text = Logger.text + ("\nSense-A-Life sensor found.")
            
            // Stop scanning
            self.centralManager.stopScan()
            // Set as the peripheral to use and establish connection
            self.SenseALifePeripheral = peripheral
            self.SenseALifePeripheral.delegate = self
            self.centralManager.connect(peripheral, options: nil)
        }
        else {
            //Logger.text = Logger.text + "\nSense-A-Life sensor not found."
        }
        
    }
    
    // Discover services of the peripheral
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        //Logger.text = Logger.text + ("\nDiscovering peripheral services")
        peripheral.discoverServices(nil)
    }
    
    // Check if the service discovered is a valid IR Temperature Service
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        //Logger.text = Logger.text + ("\nLooking at peripheral services")
        for service in peripheral.services! {
            let thisService = service as CBService
            
            if service.uuid.uuidString == "FFE0" {
                // Discover characteristics of IR Temperature Service
                peripheral.discoverCharacteristics(nil, for: thisService)
            }
        }
    }
    
    // Enable notification and sensor for each characteristic of valid service
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        // update status label
        //Logger.text = Logger.text + ("\nEnabling Sense-A-Life sensor...")
        
        // 0x01 data byte to enable sensor
        var enableValue = 1
        // ==== let enablyBytes = Data(bytes: UnsafePointer<UInt8>(&enableValue), count: sizeof(UInt8))
        
        // check the uuid of each characteristic to find config and data characteristics
        for charateristic in service.characteristics! {
            let thisCharacteristic = charateristic as CBCharacteristic
            // check for data characteristic
            if thisCharacteristic.uuid.uuidString == "FFE1" {
                // Enable Sensor Notification
                self.SenseALifePeripheral.setNotifyValue(true, for: thisCharacteristic)
                
                // Enable Sensor
                // ==== self.SenseALifePeripheral.writeValue(enablyBytes, for: thisCharacteristic, type: CBCharacteristicWriteType.withResponse)
            }
        }
    }
    
    // Get data values when they are updated
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {

        if characteristic.uuid.uuidString == "FFE1" {
            //Logger.text = Logger.text + "\n" + ((characteristic.value?.hexString())! as String)
            
            if(characteristic.isNotifying){
                //let command = NSString(data: (characteristic.value)!, encoding: NSUTF8StringEncoding)!
                
                //if(command == "ChildDetected"){
                    self.setNotificationSenseALife(5)
                    
                    self.alertImage.isHidden = false
                    self.alertLabel.isHidden = false
                    self.gasStationImage.isHidden = false
                //}
            }
        }
    }
    
    // If disconnected, start searching again
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        //Logger.text = Logger.text + ("\nDisconnected Sense-A-Life sensor...")
        central.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        //Logger.text = Logger.text + ("\nSense-A-Life sensor is ready for transmission...")
    }
    
    @IBAction func DelayForGas(_ sender: AnyObject) {
        self.setNotificationSenseALife(5)
        
        self.alertImage.isHidden = false
        self.alertLabel.isHidden = false
        self.gasStationImage.isHidden = false
    }
    
    func setNotificationSenseALife(_ intervalSinceNow: Double){
        let notification = UILocalNotification()
        notification.fireDate = Date(timeIntervalSinceNow: intervalSinceNow)
        notification.alertBody = "BABY IS IN THE CAR SEAT!!!"
        notification.soundName = "baby_in_car_seat.caf"
        notification.applicationIconBadgeNumber = 1
        notification.category = "COUNTER_CATEGORY"
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    func clearNotificationSenseALife(){
        self.alertImage.isHidden = true
        self.alertLabel.isHidden = true
        self.gasStationImage.isHidden = true
        UIApplication.shared.applicationIconBadgeNumber = -1
    }
    
}

