//
//  TweetsTableViewCell.swift
//  twitter
//
//  Created by Besart Aliju on 3/12/16.
//  Copyright © 2016 Besart Aliju. All rights reserved.
//

import UIKit

class TweetsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet{
            tweetTextLabel.text = tweet.text
            nameLabel.text = tweet.user!.name! as String
            profilePic.setImageWithURL(tweet.user!.profileUrl!)
            
            screennameLabel.text = "@\(tweet.user!.screenname!)"
            timeLabel.text = String(tweet.timestamp!)
            
            if tweet.retweetCount == 0 {
                retweetCountLabel.text = ""
            } else {
                retweetCountLabel.text = String(tweet.retweetCount)
            }
            
            if tweet.favoritesCount == 0 {
                favoriteCountLabel.text = ""
            } else {
                favoriteCountLabel.text = String(tweet.favoritesCount)
            }
            
            tweet.retweeted = false
            tweet.favorited = false
            
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profilePic.layer.cornerRadius = 5
        profilePic.clipsToBounds = true
        retweetCountLabel.text = ""
        favoriteCountLabel.text = ""
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        if tweet.retweeted == false {
            retweetButton.setImage(UIImage(named: "retweet-action-on-pressed_green.png"), forState: UIControlState.Highlighted)
            retweetButton.setImage(UIImage(named: "retweet-action-on-green.png"), forState: UIControlState.Normal)
        
            tweet.retweetCount += 1
            retweetCountLabel.text = "\(tweet.retweetCount)"
            tweet.retweeted = true
        } else {
            retweetButton.setImage(UIImage(named: "retweet-action_default.png"), forState: UIControlState.Normal)
            tweet.retweetCount -= 1
            
            if tweet.retweetCount == 0 {
                retweetCountLabel.text = ""
            } else {
                retweetCountLabel.text = "\(tweet.retweetCount)"
            }
            tweet.retweeted = false
            
        }
        
    }
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        if tweet.favorited == false {
            favoriteButton.setImage(UIImage(named: "like-action-on-pressed-red.png"), forState: UIControlState.Highlighted)
            favoriteButton.setImage(UIImage(named: "like-action-on-red.png"), forState: UIControlState.Normal)
        
            tweet.favoritesCount += 1
            favoriteCountLabel.text = "\(tweet.favoritesCount)"
            tweet.favorited = true
        } else {
            favoriteButton.setImage(UIImage(named: "like-action-off.png"), forState: UIControlState.Normal)
            
            tweet.favoritesCount -= 1
            
            if tweet.favoritesCount == 0 {
                favoriteCountLabel.text = ""
            } else {
                favoriteCountLabel.text = "\(tweet.favoritesCount)"
            }
            
            tweet.favorited = false
        }
    }

}
