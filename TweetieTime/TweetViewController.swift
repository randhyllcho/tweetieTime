//
//  TweetViewController.swift
//  TweetieTime
//
//  Created by RYAN CHRISTENSEN on 1/7/15.
//  Copyright (c) 2015 RYAN CHRISTENSEN. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
 
  var networkController : NetworkController!
  
  @IBOutlet weak var useNameLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var favoritesLabel: UILabel!
  @IBOutlet weak var imageButton: UIButton!

  @IBAction func userImageListButton(sender: AnyObject) {
    let userTwitterHistory = self.storyboard?.instantiateViewControllerWithIdentifier("LIST_OF_USER_TWEETS") as UserTweetHIstoryViewController
    userTwitterHistory.networkController = self.networkController
    userTwitterHistory.userName = tweet.userID
    userTwitterHistory.userBackground = tweet
    //userTwitterHistory.userBackground = tweet.profileBackgroundImage
    
    self.navigationController?.pushViewController(userTwitterHistory, animated: true)
  }
  var tweet : Tweet!
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.useNameLabel.text = tweet.userName
      self.tweetTextLabel.text = tweet.text
      self.favoritesLabel.text = tweet.faveCount
      
      self.imageButton.setImage(tweet.image, forState: UIControlState.Normal)
      
      self.networkController.fetchTweetID(tweet.tweetID, completionHandler: { (infoDictionary, errorMessage) -> () in
        if errorMessage == nil {
          self.tweet.updateWithInfo(infoDictionary!)
          self.favoritesLabel.text = self.tweet.faveCount

        }
      })
            
      
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
