//
//  Event.swift
//  Dawn
//
//  Created by Sam Calvert on 12/29/14.
//  Copyright (c) 2014 Elos. All rights reserved.
//

import Argo
import Foundation
import Realm
import Runes

class Event: RLMObject {
    dynamic var id: String!
    dynamic var createdAt: NSDate?
    dynamic var name: String?
    dynamic var startTime: NSDate?
    dynamic var endTime: NSDate?
    
    class func create(id: String)(createdAt: NSDate?)(name: String?)(startTime: NSDate?)(endTime: NSDate?) -> Event {
        let event = Event()
        
        event.id = id
        event.createdAt = createdAt
        event.name = name
        event.startTime = startTime
        event.endTime = endTime
        
        return event
    }
}

extension Event: JSONDecodable {
    class func decode(j: JSONValue) -> Event? {
        return Event.create
            <^> j <| "id"
            <*> j <| "createdAt"
            <*> j <| "name"
            <*> j <| "startTime"
            <*> j <| "endTime"
    }
}