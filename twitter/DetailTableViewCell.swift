//
//  DetailTableViewCell.swift
//  twitter
//
//  Created by Besart Aliju on 3/19/16.
//  Copyright © 2016 Besart Aliju. All rights reserved.
//

import UIKit
import AFNetworking

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userScreenname: UILabel!
    
    @IBOutlet weak var userUsername: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
    
    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var favoriteCount: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    let client = TwitterClient.sharedInstance
    var currentID: String = ""
    
    var tweets: Tweet! {
        didSet{
            currentID = tweets.id_str
            userScreenname.text = tweets.user?.screenname as! String
            userUsername.text = tweets.user?.name as! String
            tweetText.text = tweets.text
            retweetCount.text = ("\(tweets.retweetCount)")
            favoriteCount.text = ("\(tweets.favoritesCount)")
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
