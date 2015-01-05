//
//  ViewController.swift
//  TweetieTime
//
//  Created by RYAN CHRISTENSEN on 1/5/15.
//  Copyright (c) 2015 RYAN CHRISTENSEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
 
  @IBOutlet weak var tableView: UITableView!

  
  var tweets = [Tweet]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let jsonPath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
      if let jsonData = NSData(contentsOfFile: jsonPath){
        var error : NSError?
        if let jsonArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [AnyObject] {
          for object in jsonArray {
            if let jsonDictionary = object as? [String : AnyObject] {
              let tweet = Tweet(jsonDictionary)
              self.tweets.append(tweet)
            }
          }
        }
      }
    }
   
    
    self.tableView.dataSource = self
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as TweetCell
    let tweet = self.tweets[indexPath.row]
    cell.tweetLabel.text = tweet.text
    return cell
  }
  


}

