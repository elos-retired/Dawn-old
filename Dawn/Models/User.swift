//
//  User.swift
//  Dawn
//
//  Created by Sam Calvert on 12/27/14.
//  Copyright (c) 2014 Elos. All rights reserved.
//

import Argo
import Foundation
import Runes
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
            var error: NSError?
            let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error)
            
            if let j: AnyObject = json {
                currentUserInstance = User.decode(JSONValue.parse(j))
                if let u = currentUserInstance {
                    if let j = u.toJsonString() {
                        NSLog(u.id.toString())
                        NSLog(j)
                    }
                }
            }
        })
        
        task.resume()
        return user
    }
    
    override init() {
        
    }
    
    init(id _id: ObjectId, createdAt _createdAt: NSDate, name _name: String, key _key: String) {
        id = _id
        createdAt = _createdAt
        name = _name
        key = _key
    }
    
    func idKeyPair() -> String? {
        if id != nil && key != nil {
            return "\(id.toString())-\(key)"
        } else {
            return nil
        }
    }
}

extension User: JSONDecodable {
    class func create(id: ObjectId)(createdAt: NSDate)(name: String)(key: String) -> User {
        return User(id: id, createdAt: createdAt, name: name, key: key)
    }
    
    class func decode(j: JSONValue) -> User? {
        return User.create
            <^> j <| "id"
            <*> j <| "created_at"
            <*> j <| "name"
            <*> j <| "key"
    }
}