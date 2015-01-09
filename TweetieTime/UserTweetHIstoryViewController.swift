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
  
  var userName : String = ""
  
  var tweetish = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.networkController.fetchUserTweetHistory(userName, completionHandler: { (tweetHistory, error) -> () in
        if error == nil {
        
        }
      })

        // Do any additional setup after loading the view.
      self.tableView.DataSource = self
    }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TWEET_CELL", forIndexPath: indexPath) as TweetCell
    
    let tweets = self.tweetish[indexPath.row]
    
    
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
