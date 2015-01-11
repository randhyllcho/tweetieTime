//
//  ViewController.swift
//  TweetieTime
//
//  Created by RYAN CHRISTENSEN on 1/5/15.
//  Copyright (c) 2015 RYAN CHRISTENSEN. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
  @IBOutlet weak var tableView: UITableView!
  let networkController = NetworkController()
  var tweets = [Tweet]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0, green: 0.675, blue: 0.93, alpha: 1.0)
    
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TWEET_CELL")
    self.tableView.estimatedRowHeight = 144
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
    self.networkController.fetchHomeTimeline { (tweets, errorString) -> () in
      if errorString == nil {
        self.tweets = tweets!
        self.tableView.reloadData()
      }
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      let tweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("TWEET_VC") as TweetViewController
      tweetVC.networkController = self.networkController
      tweetVC.tweet = tweets[indexPath.row]
    self.navigationController?.pushViewController(tweetVC, animated: true)
    } 

  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as TweetCell
    let tweet = self.tweets[indexPath.row]
    cell.tweetLabel.text = tweet.text
    cell.userNameLabel.text = tweet.userName
    
    if tweet.image == nil {
      self.networkController.fetchImageForTweet(tweet, completionHandler: { (image) -> () in
        cell.userImageView?.image = tweet.image
        cell.userImageView?.layer.cornerRadius = 3.7
        cell.userImageView?.layer.masksToBounds = true
        cell.userImageView?.layer.borderColor = UIColor.whiteColor().CGColor
        cell.userImageView?.layer.borderWidth = 0
      })
    } else {
      cell.userImageView?.image = tweet.image?
    }
    
    return cell
  }

}

