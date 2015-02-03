//
//  Message.swift
//  Dawn
//
//  Created by Sam Calvert on 1/10/15.
//  Copyright (c) 2015 Elos. All rights reserved.
//

import Argo
import Foundation
import Runes

enum Action: String {
    case Get = "GET"
    case Post = "POST"
    case Delete = "DELETE"
    case Error = "ERROR"
}

extension Action: JSONDecodable {
    static func decode(j: JSONValue) -> Action? {
        if let actionString: String = j.value() {
            return Action(rawValue: actionString)
        } else {
            return .None
        }
    }
}

struct Message {
    let action: Action
    let data: NSDictionary
}

extension Message: JSONDecodable {
    static func create(action: Action)(data: NSDictionary) -> Message {
        return Message(action: action, data: data)
    }
    
    static func decode(j: JSONValue) -> Message? {
        return Message.create
            <^> j <| "action"
            <*> j <| "data"
    }
}