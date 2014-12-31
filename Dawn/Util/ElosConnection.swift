//
//  ElosConnection.swift
//  Dawn
//
//  Created by Sam Calvert on 12/30/14.
//  Copyright (c) 2014 Elos. All rights reserved.
//

import Foundation
import SocketRocket
import SwiftyJSON

var elosConnectionInstance: ElosConnection?

class ElosConnection: NSObject, SRWebSocketDelegate {
    var socket: SRWebSocket!
    
    class func sharedConnection() -> ElosConnection {
        if elosConnectionInstance == nil {
            elosConnectionInstance = ElosConnection()
        }
        return elosConnectionInstance!
    }
    
    override init() {
        super.init()
        reconnect()
    }
    
    func reconnect() {
        if socket != nil {
            socket.delegate = nil
        }
        
        if let key = User.currentUser()?.idKeyPair() {
            var request = NSURLRequest(URL: NSURL(string: "ws://localhost:8000/v1/authenticate")!)
            socket = SRWebSocket(URLRequest: request, protocols: [key])
            socket.delegate = self
            socket.open()
        }
        
    }
    
    func webSocket(webSocket: SRWebSocket!, didReceiveMessage message: AnyObject!) {
        
    }
}