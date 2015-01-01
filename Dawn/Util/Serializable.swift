//
//  Serializable.swift
//  Dawn
//
//  Created by Sam Calvert on 12/31/14.
//  Copyright (c) 2014 Elos. All rights reserved.
//

import Foundation

class Serializable: NSObject {
    func toDict() -> NSDictionary {
        var klass = self.dynamicType
        var propertiesCount: CUnsignedInt = 0
        var propertiesInKlass = class_copyPropertyList(klass, &propertiesCount)
        var propertiesDict = NSMutableDictionary()
        
        for var i = 0; i < Int(propertiesCount); i++ {
            var property = propertiesInKlass[i]
            var propertyName = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding)!
            var propertyValue: AnyObject! = self.valueForKey(propertyName)
            
            if propertyValue is Serializable {
                propertiesDict.setValue((propertyValue as Serializable).toDict(), forKey: propertyName)
            } else if propertyValue is Array<Serializable> {
                var array = Array<NSDictionary>()
                for item in (propertyValue as Array<Serializable>) {
                    array.append(item.toDict())
                }
                propertiesDict.setValue(array, forKey: propertyName)
            } else if propertyValue is NSDate {
                propertiesDict.setValue(ElosDateFormatter.stringFromDate(propertyValue as? NSDate), forKey: propertyName)
            } else {
                propertiesDict.setValue(propertyValue, forKey: propertyName)
            }
        }
        
        return propertiesDict
    }
    
    func toJson() -> NSData? {
        return NSJSONSerialization.dataWithJSONObject(self.toDict(), options:NSJSONWritingOptions(0), error: nil)
    }
    
    func toJsonString() -> NSString? {
        if let data = self.toJson() {
            return NSString(data: data, encoding: NSUTF8StringEncoding)
        } else {
            return nil
        }
    }
}