//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Timothy Mak on 12/24/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var messageImageView: UIImageView!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        if let tweet = tweet {
            profileImageView.af_setImage(withURL: tweet.user.profileImageUrl!)
            usernameLabel.text = tweet.user.name
            screennameLabel.text = tweet.user.screenName
            bodyLabel.text = tweet.text
            timestampLabel.text = tweet.createdAtString
            retweetCountLabel.text = String(tweet.retweetCount)
            likeCountLabel.text = String(tweet.favoriteCount)
        }
        
        replyImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onReply)))
        retweetImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onRetweet)))
        favoriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFavorite)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onReply() {
        
    }
    
    func onRetweet() {
        Tweet.retweet(tweet: tweet!)
        updateImages()
        updateCountLabels()
    }
    
    func onFavorite() {
        Tweet.favorite(tweet: tweet!)
        updateImages()
        updateCountLabels()
    }
    
    func updateImages() {
        if tweet!.retweeted {
            retweetImageView.image = UIImage(named: "retweet-icon-green")
        }
        else {
            retweetImageView.image = UIImage(named: "retweet-icon")
        }
        
        if tweet!.favorited {
            favoriteImageView.image = UIImage(named: "favor-icon-red")
        }
        else {
            favoriteImageView.image = UIImage(named: "favor-icon")
        }
    }
    
    func updateCountLabels() {
        retweetCountLabel.text = String(describing: tweet!.retweetCount)
        likeCountLabel.text = String(describing: tweet!.favoriteCount)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
