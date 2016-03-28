//
//  ComposeViewController.swift
//  twitter
//
//  Created by Besart Aliju on 3/26/16.
//  Copyright © 2016 Besart Aliju. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    let client = TwitterClient.sharedInstance
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTweet(sender: AnyObject) {
        //client.sendTweet()
        //sendTweet
        //dismissviewcontroller
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
