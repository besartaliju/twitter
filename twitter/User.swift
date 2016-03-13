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
    
    var dictionary: NSDictionary?
    
    static var userDidLogoutNotification = "UserDidLogout"
    
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString =  profileUrlString{
            profileUrl = NSURL(string: profileUrlString)
        }
        
        tagline = dictionary["description"] as? String
    
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
