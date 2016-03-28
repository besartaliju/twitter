//
//  ProfileViewController.swift
//  twitter
//
//  Created by Besart Aliju on 3/26/16.
//  Copyright © 2016 Besart Aliju. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileScreenname: UILabel!
    @IBOutlet weak var numberTweets: UILabel!
    @IBOutlet weak var numberFollowing: UILabel!
    @IBOutlet weak var numberFollowers: UILabel!
    
    var tweet: Tweet?
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileName.text = user?.name as! String
        profileScreenname.text = user?.screenname as! String
        numberTweets.text = "\(user?.tweetsCount)"
        numberFollowing.text = "\(user?.followingCount)"
        numberFollowers.text = "\(user?.followersCount)"
        profileImage.setImageWithURL((user?.profileUrl)!)
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
