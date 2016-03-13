//
//  Tweet.swift
//  twitter
//
//  Created by Besart Aliju on 3/5/16.
//  Copyright © 2016 Besart Aliju. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var text: String?    //changed from NSString? to String? Change back if anything
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var favorited: Bool
    var retweeted: Bool
    var id_str: String
    //var screenname: String
    //var name: String
    
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text =  dictionary["text"] as? String
        id_str = (dictionary["id_str"] as? String)!

        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        favorited = dictionary["favorited"] as! Bool
        retweeted = dictionary["retweeted"] as! Bool
        
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timestamp = formatter.dateFromString(dictionary["created_at"] as! String)
        
        //screenname = dictionary["user"]!["screen_name"] as! String
        //name = dictionary["user"]!["name"] as! String
        
        

    }
    
    
    func retweet(){
        
        
    }
    
    func favorite(){
    
    
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }

}
