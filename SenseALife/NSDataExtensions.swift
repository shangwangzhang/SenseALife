//
//  NSDataExtensions.swift
//  SenseALife
//
//  Created by ShangWang Zhang on 1/31/16.
//  Copyright © 2016 ShangWang. All rights reserved.
//

import Foundation
import UIKit

extension Data {
    func hexString() -> NSString {
        let str = NSMutableString()
        let bytes = UnsafeBufferPointer<UInt8>(start: (self as NSData).bytes.bindMemory(to: UInt8.self, capacity: self.count), count:self.count)
        for byte in bytes {
            str.appendFormat("%02hhx", byte)
        }
        return str
    }
}
