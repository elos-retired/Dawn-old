//
//  Event.swift
//  Dawn
//
//  Created by Sam Calvert on 12/29/14.
//  Copyright (c) 2014 Elos. All rights reserved.
//

import Argo
import Foundation
import Runes

struct Event {
    let id: ObjectId
    let createdAt: NSDate?
    let name: String?
    let startTime: NSDate?
    let endTime: NSDate?
}

extension Event: JSONDecodable {
    static func create(id: ObjectId)(createdAt: NSDate?)(name: String?)(startTime: NSDate?)(endTime: NSDate?) -> Event {
        return Event(id: id, createdAt: createdAt, name: name, startTime: startTime, endTime: endTime)
    }
    
    static func decode(j: JSONValue) -> Event? {
        return Event.create
            <^> j <| "id"
            <*> j <| "createdAt"
            <*> j <| "name"
            <*> j <| "startTime"
            <*> j <| "endTime"
    }
}