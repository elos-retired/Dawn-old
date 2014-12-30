//
//  ElosDateFormatter.swift
//  Dawn
//
//  Created by Sam Calvert on 12/29/14.
//  Copyright (c) 2014 Elos. All rights reserved.
//

import Foundation

var elosDateFormatterInstance: ElosDateFormatter?

class ElosDateFormatter: NSDateFormatter {
    class func getSharedFormatter() -> ElosDateFormatter {
        if let instance = elosDateFormatterInstance {
            return instance
        } else {
            elosDateFormatterInstance = ElosDateFormatter()
            return elosDateFormatterInstance!
        }
    }
    
    class func dateFromString(string: String?) -> NSDate? {
        if string != nil {
            return ElosDateFormatter.getSharedFormatter().dateFromString(string!)
        } else {
            return nil
        }
    }
    
    override init() {
        super.init()
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSSxxx"
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}