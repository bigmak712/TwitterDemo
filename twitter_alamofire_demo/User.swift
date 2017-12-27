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
    var screenName: String
    var description: String
    var followersCount: Int
    var followingCount: Int
    var profileImageUrl: URL?
    var profileBackgroundUrl: URL?
    var profileBannerUrl: URL?
    
    init(dictionary: [String: Any]) {
        
        self.dictionary = dictionary
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as! String
        screenName = "@" + screenName
        description = dictionary["description"] as! String
        followersCount = dictionary["followers_count"] as! Int
        followingCount = dictionary["friends_count"] as! Int
        
        let profileImageUrlString = dictionary["profile_image_url_https"] as? String
        if let profileImageUrlString = profileImageUrlString {
            profileImageUrl = URL(string: profileImageUrlString)
        }
        else {
            profileImageUrl = URL(string: "")
        }
        
        let profileBackgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        if let profileBackgroundUrlString = profileBackgroundUrlString {
            profileBackgroundUrl = URL(string: profileBackgroundUrlString)
        }
        else {
            profileBackgroundUrl = URL(string: "")
        }
        
        let profileBannerUrlString = dictionary["profile_banner_url"] as? String
        if let profileBannerUrlString = profileBannerUrlString {
            profileBannerUrl = URL(string: profileBannerUrlString)
        }
        else {
            profileBannerUrl = URL(string: "")
        }
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
