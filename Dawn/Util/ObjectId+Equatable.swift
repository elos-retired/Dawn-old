//
//  ObjectId+Equatable.swift
//  Dawn
//
//  Created by Sam Calvert on 12/29/14.
//  Copyright (c) 2014 Elos. All rights reserved.
//

import Foundation

extension ObjectId: Equatable {}

func ==(lhs: ObjectId, rhs: ObjectId) -> Bool {
    return lhs.timestamp == rhs.timestamp &&
           lhs.machine == rhs.machine &&
           lhs.pid == rhs.pid &&
           lhs.increment == rhs.increment
}

func ==(lhs: ObjectId, rhs: String) -> Bool {
    if let other = ObjectId(mongoId: rhs) {
        return lhs == other
    } else {
        return false
    }
}

func ==(lhs: String, rhs: ObjectId) -> Bool {
    return rhs == lhs
}