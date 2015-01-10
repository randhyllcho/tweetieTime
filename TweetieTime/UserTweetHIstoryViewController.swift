//
//  UserTweetHIstoryViewController.swift
//  TweetieTime
//
//  Created by RYAN CHRISTENSEN on 1/8/15.
//  Copyright (c) 2015 RYAN CHRISTENSEN. All rights reserved.
//

import UIKit

class UserTweetHIstoryViewController: UIViewController, UITableViewDataSource {
  
  var networkController : NetworkController!
  
  @IBOutlet weak var backgroundImageView: UIImageView?
  
  @IBOutlet weak var locationLabel: UILabel!
  
  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var userNameLAbel: UILabel!
  
  @IBOutlet weak var tableView: UITableView!
  
  
  var userName : String?
  
  var userBackground : Tweet!
  
  var tweetish = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()
      self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TWEET_CELL")
      self.tableView.estimatedRowHeight = 144
      self.tableView.rowHeight = UITableViewAutomaticDimension
      
      self.networkController.fetchUserTweetHistory(userName!, completionHandler: { (tweetHistory, error) -> () in
        if error == nil {
          self.tweetish = tweetHistory!
          self.tableView.reloadData()
        }
      })
      
            self.tableView.dataSource = self
      
        // Do any additional setup after loading the view.
      
    }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as TweetCell
      let tweet = self.tweetish[indexPath.row]
      cell.tweetLabel.text = tweet.text
      cell.userNameLabel.text = tweet.userName
      self.userNameLAbel.text = tweet.userName
      self.locationLabel.text = tweet.location
    
    if tweet.image == nil {
      self.networkController.fetchImageForTweet(tweet, completionHandler: { (image) -> () in
        cell.userImageView.image = tweet.image
        self.imageView.image = tweet.image
        
        self.imageView?.layer.masksToBounds = true
        self.imageView?.layer.borderColor = UIColor.whiteColor().CGColor
        self.imageView?.layer.borderWidth = 3.1
        self.imageView?.layer.cornerRadius = 3.7
        
        cell.userImageView?.layer.masksToBounds = true
        cell.userImageView?.layer.cornerRadius = 3.0
        cell.userImageView?.layer.borderColor = UIColor.darkGrayColor().CGColor
        cell.userImageView?.layer.borderWidth = 2
       
      })
      self.networkController.fetchBackgroundBanner(self.userBackground, completionHandler: { (image) -> () in
        if self.backgroundImageView!.image == nil {
          self.backgroundImageView!.image = self.userBackground.backgroundImage
        }
      })

  }
    

    return cell
  }
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweetish.count
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
