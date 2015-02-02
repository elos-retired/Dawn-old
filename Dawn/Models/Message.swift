//
//  Message.swift
//  Dawn
//
//  Created by Sam Calvert on 1/10/15.
//  Copyright (c) 2015 Elos. All rights reserved.
//

import Foundation

enum Action {
    case Get
    case Post
    case Delete
    case Error
}

class Message {
    var action: Action!
}