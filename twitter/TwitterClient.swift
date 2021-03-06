//
//  TwitterClient.swift
//  twitter
//
//  Created by Besart Aliju on 3/6/16.
//  Copyright © 2016 Besart Aliju. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "PkNbNSWzM08svYyGJHsRxJk3A", consumerSecret: 	"R0NePNFbdYiWIVycdXKJ6OUqDBYK8mrVaoEIiYTSiLPttLtZ0V")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?

    
    func login(success: () -> (), failure: (NSError) -> ()){
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitter://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }

    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST" , requestToken: requestToken, success: { (accessToken : BDBOAuth1Credential!) -> Void in
            print("I got an access token")
            
            self.currentAccount({ (user:User) -> () in
                    User.currentUser = user
                    self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
            
            self.loginSuccess?()
            
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }

    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            //remember that there is a for statement here to read all of the tweets and then print them out
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })

    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("account: \(response)")
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
        
            success(user)
            
    
            }, failure:
            { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })

    }
    
    func retweet(id_str: String) {
        POST("1.1/statuses/retweet/\(id_str).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Retweeting a tweet!")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        })
    }
    
    func favorite(id_str: String) {
        POST("1.1/favorites/create.json?id=\(id_str)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Favoriting a tweet")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        }
    
    }
    
    func unretweet(id_str: String) {
        POST("1.1/statuses/unretweet/\(id_str).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Unretweeting a tweet")
            }) { (task: NSURLSessionDataTask?,error: NSError) -> Void in
                print(error.localizedDescription)
        }
    }
    
    func sendTweet(id_str: String) {
        POST("1.1/statuses/update.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("tweeting")
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            print(error.localizedDescription)
        }
    }
    
    

}
