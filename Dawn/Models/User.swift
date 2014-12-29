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

class User {
    var id: ObjectId!
    var createdAt: NSDate!
    var name: String!
    var key: String!
    
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
            
            if let strCreatedAt = data["createdAt"].string {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSSSxxx"
                user.createdAt = dateFormatter.dateFromString(strCreatedAt)
            }
            
            user.key = data["key"].string
            println(user.idKeyPair())
        })
        
        task.resume()
        return user
    }
    
    func idKeyPair() -> String {
        return "\(id.toString())-\(key)"
    }
}