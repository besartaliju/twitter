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
            
            screennameLabel.text = "@\(tweet.user!.screenname!)"
            timeLabel.text = String(tweet.timestamp)
            
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

}
