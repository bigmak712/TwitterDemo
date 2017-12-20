//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screenameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var messageImageView: UIImageView!
    
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            if let photoUrl = tweet.user.profileImageUrl {
                profileImageView.af_setImage(withURL: photoUrl as URL)
            }
            profileImageView.layer.masksToBounds = false
            profileImageView.layer.cornerRadius = profileImageView.frame.height/2
            profileImageView.clipsToBounds = true
            
            usernameLabel.text = tweet.user.name
            screenameLabel.text = tweet.user.screenName
            timestampLabel.text = tweet.createdAtString
            
            bodyLabel.text = tweet.text
            
            replyImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onReply)))
            retweetImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onRetweet)))
            favoriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFavorite)))
            
            updateCountLabels()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func onReply() {
        
    }
    
    func onRetweet() {
        
    }
    
    func onFavorite() {
        if tweet.favorited {
            
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
        
        updateCountLabels()
    }
    
    func updateCountLabels() {
        replyCountLabel.text = String(tweet.replyCount)
        retweetCountLabel.text = String(tweet.retweetCount)
        favoriteCountLabel.text = String(tweet.favoriteCount)
    }
}
