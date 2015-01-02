//
//  User.swift
//  Dawn
//
//  Created by Sam Calvert on 12/27/14.
//  Copyright (c) 2014 Elos. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

var currentUserInstance: User?

class User: Serializable {
    var id: ObjectId!
    var createdAt: NSDate!
    var name: String!
    var key: String!
    
    class func currentUser() -> User? {
        return currentUserInstance
    }
    
    class func setCurrentUser(user: User?) {
        currentUserInstance = user
    }
    
    class func create() -> User {
        let user = User()
        user.name = UIDevice.currentDevice().identifierForVendor.UUIDString
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8000/v1/users")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.HTTPBody = ("name=" + user.name!).dataUsingEncoding(NSUTF8StringEncoding)
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let data = JSON(data: data)
            user.id = ObjectId(mongoId: data["id"].string)
            user.createdAt = ElosDateFormatter.dateFromString(data["created_at"].string)
            user.key = data["key"].string
        })
        
        task.resume()
        return user
    }
    
    func idKeyPair() -> String? {
        if id != nil && key != nil {
            return "\(id.toString())-\(key)"
        } else {
            return nil
        }
    }
}