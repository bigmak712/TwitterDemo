//
//  Tweet.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class Tweet {
    
    // MARK: Properties
    var id: Int64 // For favoriting, retweeting & replying
    var text: String // Text content of tweet
    var favoriteCount: Int // Update favorite count label
    var favorited: Bool // Configure favorite button
    var retweetCount: Int // Update favorite count label
    var retweeted: Bool // Configure retweet button
    var user: User // Contains name, screenname, etc. of tweet author
    var createdAtString: String // Display date
    
    // reply_count field is only available on enterprise APIs 
    // var replyCount: Int
    
    // MARK: - Create initializer with dictionary
    init(dictionary: [String: Any]) {
        id = dictionary["id"] as! Int64
        text = dictionary["text"] as! String
        favoriteCount = dictionary["favorite_count"] as! Int
        favorited = dictionary["favorited"] as! Bool
        retweetCount = dictionary["retweet_count"] as! Int
        retweeted = dictionary["retweeted"] as! Bool
        
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
        
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        // Convert String to Date
        let date = formatter.date(from: createdAtOriginalString)!
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        // Convert Date to String
        createdAtString = formatter.string(from: date)
    }
    
    static func retweet(tweet: Tweet) {
        if tweet.retweeted {
            APIManager.shared.unretweet(tweet, completion: { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                }
                else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            })
            
            tweet.retweeted = false
            tweet.retweetCount -= 1
        }
        else {
            APIManager.shared.retweet(tweet, completion: { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                }
                else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            })
            
            tweet.retweeted = true
            tweet.retweetCount += 1
        }
    }
    
    static func favorite(tweet: Tweet) {
        if tweet.favorited {
            APIManager.shared.unfavorite(tweet, completion: { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                }
                else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            })
            
            tweet.favorited = false
            tweet.favoriteCount -= 1
        }
        else {
            APIManager.shared.favorite(tweet, completion: { (tweet: Tweet?, error: Error?) in
                if let error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                }
                else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            })
            
            tweet.favorited = true
            tweet.favoriteCount += 1
        }
    }
}

