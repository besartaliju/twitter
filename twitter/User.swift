//
//  User.swift
//  twitter
//
//  Created by Besart Aliju on 3/5/16.
//  Copyright © 2016 Besart Aliju. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    var profileBannerUrl: NSURL?
    var dictionary: NSDictionary?
    var profileBackgroundImageUrl: NSURL?
    var followersCount: Int?
    var followingCount: Int?
    var tweetsCount: Int?
    var profileDescription: String?
    
    static var userDidLogoutNotification = "UserDidLogout"
    
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        followersCount = dictionary["followers"] as? Int
        followingCount = dictionary["following"] as? Int
        tweetsCount = dictionary["tweets"] as? Int
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString =  profileUrlString{
            profileUrl = NSURL(string: profileUrlString)
        }
        
        let profileBackgroundImageUrlString = dictionary["profile_background_image_url_https"] as? String
        if let profileBackgroundImageUrlString = profileBackgroundImageUrlString{
            profileBackgroundImageUrl = NSURL(string: profileBackgroundImageUrlString)
        }
        
        tagline = dictionary["description"] as? String
        
        followersCount = dictionary["followers_count"] as? Int
        profileDescription = dictionary["description"] as? String
    
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
            let defaults = NSUserDefaults.standardUserDefaults()
            
            let userData = defaults.objectForKey("currentUserData") as? NSData
        
            if let userData = userData{
                let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: [])
        
                _currentUser = User(dictionary: dictionary as! NSDictionary)
            }
        }
            return _currentUser
        }
        
        set(user) {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            
            
            defaults.setObject(user, forKey: "currentUser")
            defaults.synchronize()
        }
        
    }
}
