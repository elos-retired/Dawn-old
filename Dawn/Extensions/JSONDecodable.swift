//
//  JSONDecodable.swift
//  Dawn
//
//  Created by Sam Calvert on 2/2/15.
//  Copyright (c) 2015 Elos. All rights reserved.
//

import Argo
import Foundation

extension NSDate: JSONDecodable {
    public class func decode(j: JSONValue) -> NSDate? {
        return ElosDateFormatter.dateFromString(j.value())
    }
}

extension NSDictionary: JSONDecodable {
    public class func decode(j: JSONValue) -> NSDictionary? {
        return j.value()
    }
}

extension ObjectId: JSONDecodable {
    internal class func decode(j: JSONValue) -> ObjectId? {
        return ObjectId(mongoId: j.value())
    }
}