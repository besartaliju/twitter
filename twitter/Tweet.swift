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
    var text: String?    
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var favorited: Bool
    var retweeted: Bool
    var id_str: String
    var imageURL: NSURL?
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
        
        let imageURLString = dictionary["profile_image_url"] as? String
        if let imageURLString = imageURLString{
            imageURL = NSURL(string: imageURLString)
        }
        
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timestamp = formatter.dateFromString(dictionary["created_at"] as! String)

    }
    
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    
    func favorite(completion: (tweet: Tweet?, error: NSError?) -> ()) {
        TwitterClient.sharedInstance.POST(
            "1.1/favorites/create.json?id=\(id_str)",
            parameters: nil,
            progress: nil,
            success: { (_: NSURLSessionDataTask, _: AnyObject?) -> Void in
                self.favorited = true
                self.favoritesCount++
                completion(tweet: self, error: nil)
            },
            failure: { (_: NSURLSessionDataTask?, error: NSError) -> Void in
                completion(tweet: nil, error: error)
            }
        )
    }
    
    func retweet(completion: (tweet: Tweet?, error: NSError?) -> ()) {
        TwitterClient.sharedInstance.POST(
            "1.1/statuses/retweet/\(id_str).json",
            parameters: nil,
            progress: nil,
            success: { (_: NSURLSessionDataTask, _: AnyObject?) -> Void in
                self.retweeted = true
                self.retweetCount++
                completion(tweet: self, error: nil)
            },
            failure: { (_: NSURLSessionDataTask?, error: NSError) -> Void in
                completion(tweet: nil, error: error)
            }
        )
    }


}
