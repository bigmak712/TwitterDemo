//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Timothy Mak on 12/20/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetTextView: UITextView!
    
    var photoUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        tweetButton.isEnabled = false
        
        tweetTextView.text = "What's happening?"
        tweetTextView.textColor = UIColor.gray
        
        if let photoUrl = photoUrl {
            profileImageView.af_setImage(withURL: photoUrl)
        }
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweet(_ sender: UIButton) {
        let tweetText = tweetTextView.text!
        APIManager.shared.composeTweet(with: tweetText) { (tweet: Tweet?, error: Error?) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if tweet != nil {
                print("Compose Tweet Success!")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClose(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if tweetTextView.textColor == UIColor.gray {
            tweetTextView.text = ""
            tweetTextView.textColor = UIColor.black
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        if tweetTextView.text.isEmpty {
            tweetButton.isEnabled = false
        }
        else {
            tweetButton.isEnabled = true
        }
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
