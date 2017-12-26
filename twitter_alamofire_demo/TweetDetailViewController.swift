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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
