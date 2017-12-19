//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    private static var currentUser: User?
    
    // for user persistence
    var dictionary: [String: Any]?
    
    var name: String
    
    init(dictionary: [String: Any]) {
        
        self.dictionary = dictionary
        name = dictionary["name"] as! String

    }
    
    static var current: User? {
        get {
            if currentUser == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    currentUser = User(dictionary: dictionary)
                }
            }
            return currentUser
        }
        set (user) {
            currentUser = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            }
            else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
}
