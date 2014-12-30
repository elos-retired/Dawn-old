//
//  Event.swift
//  Dawn
//
//  Created by Sam Calvert on 12/29/14.
//  Copyright (c) 2014 Elos. All rights reserved.
//

import Foundation

class Event {
    var id: ObjectId!
    
    var createdAt: NSDate?
    var name: String?
    var startTime: NSDate?
    var endTime: NSDate?
    
    class func create() -> Event {
        let event = Event()
        
        event.id = ObjectId()
        event.createdAt = NSDate()
        
        return event
    }
    
    class func create(name: String) -> Event {
        let event = Event.create()
        event.name = name
        return event
    }
    
    class func create(name: String, startTime: NSDate) -> Event {
        let event = Event.create(name)
        event.startTime = startTime
        return event
    }
    
    class func create(name: String, startTime: NSDate, endTime: NSDate) -> Event {
        let event = Event.create(name, startTime: startTime)
        event.endTime = endTime
        return event
    }
}