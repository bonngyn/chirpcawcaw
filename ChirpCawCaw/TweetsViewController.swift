//
//  TweetsViewController.swift
//  ChirpCawCaw
//
//  Created by Bonnie Nguyen on 6/29/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        refreshData()
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            
            for tweet in tweets {
                print(tweet.text)
            }
        }) { (error: NSError) -> () in
            print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myTweetCell", forIndexPath: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        
        cell.usernameLabel.text = tweet.user?.name as? String
        cell.screenNameLabel.text = tweet.user?.screenname as? String
        cell.tweetLabel.text = tweet.text as? String
        
        let url = tweet.user?.profileUrl
        
        if let data = NSData(contentsOfURL: url!) {
            cell.userImage.image = UIImage(data:data)
        }
        
        
        
        return cell
    }
    
    func refreshData() {
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }) { (error: NSError) in
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    @IBAction func replyButton(sender: AnyObject) {
        
    }
    
    @IBAction func retweetButton(sender: AnyObject) {
        
    }
    
    @IBAction func likeButton(sender: AnyObject) {
        
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
