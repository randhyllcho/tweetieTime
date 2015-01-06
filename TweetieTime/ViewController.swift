//
//  ViewController.swift
//  TweetieTime
//
//  Created by RYAN CHRISTENSEN on 1/5/15.
//  Copyright (c) 2015 RYAN CHRISTENSEN. All rights reserved.
//

import UIKit
import Accounts
import Social


class ViewController: UIViewController, UITableViewDataSource {
 
  @IBOutlet weak var tableView: UITableView!

  
  var tweets = [Tweet]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
      if granted {
        let accounts = accountStore.accountsWithAccountType(accountType)
        if !accounts.isEmpty {
          let twitterAccount = accounts.first as ACAccount
          let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
          let twittertRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
          twittertRequest.account = twitterAccount
          twittertRequest.performRequestWithHandler(){ (data, response, error) -> Void in
            switch response.statusCode {
            case 200...299:
              println("This worked")
              
              if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [AnyObject] {
                for object in jsonArray {
                  if let jsonDictionary = object as? [String : AnyObject] {
                    let tweet = Tweet(jsonDictionary)
                    self.tweets.append(tweet)
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                      self.tableView.reloadData()
                    })
                  }
                }
              }
            case 300...599:
              println("Not good buddy")
            default:
              ("Default was fired")
            }
          }
        }
      }
    }
    
    
    
//    if let jsonPath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
//      if let jsonData = NSData(contentsOfFile: jsonPath){
//        var error : NSError?
//    
//        if let jsonArray = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [AnyObject] {
//          for object in jsonArray {
//            if let jsonDictionary = object as? [String : AnyObject] {
//              let tweet = Tweet(jsonDictionary)
//              self.tweets.append(tweet)
//            }
//          }
//        }
      //}
    //}
   
  
    
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
    cell.userNameLabel.text = tweet.userName
    let imgURl = NSURL(string: tweet.tweetImage!)
    let imageData = NSData(contentsOfURL: imgURl!)
    let images = UIImage(data: imageData!)
    cell.userImageView.image = images
    
    return cell
  }
  


}

