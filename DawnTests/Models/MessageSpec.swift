//
//  MessageSpec.swift
//  Dawn
//
//  Created by Sam Calvert on 2/2/15.
//  Copyright (c) 2015 Elos. All rights reserved.
//

import Dawn
import Nimble
import Quick

class MessageSpec: QuickSpec {
    override func spec() {
        describe("JSON decoding") {
            it("decodes a JSON string into an action and some data") {
                let msgData = "{action:\"POST\",data:{}}".dataUsingEncoding(NSUTF8StringEncoding)!
            }
        }
    }
}