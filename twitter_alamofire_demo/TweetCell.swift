//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

protocol TweetCellDelegate: class {
    func tweetCell(_ tweetCell: TweetCell, didTap user: User)
}

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
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    weak var delegate: TweetCellDelegate?
    
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
            
            updateImages()
            updateCountLabels()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let profileTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapUserProfile(_:)))
        profileImageView.addGestureRecognizer(profileTapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func didTapUserProfile(_ sender: UITapGestureRecognizer) {
        delegate?.tweetCell(self, didTap: tweet.user)
    }
    
    func onReply() {
        
    }
    
    func onRetweet() {
        Tweet.retweet(tweet: tweet)
        
        updateImages()
        updateCountLabels()
    }
    
    func onFavorite() {
        Tweet.favorite(tweet: tweet)
        
        updateImages()
        updateCountLabels()
    }
    
    func updateImages() {
        if tweet.retweeted {
            retweetImageView.image = UIImage(named: "retweet-icon-green")
        }
        else {
            retweetImageView.image = UIImage(named: "retweet-icon")
        }
        
        if tweet.favorited {
            favoriteImageView.image = UIImage(named: "favor-icon-red")
        }
        else {
            favoriteImageView.image = UIImage(named: "favor-icon")
        }
    }
    func updateCountLabels() {
        retweetCountLabel.text = String(tweet.retweetCount)
        favoriteCountLabel.text = String(tweet.favoriteCount)
    }
}
