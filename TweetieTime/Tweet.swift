//
//  Tweet.swift
//  TweetieTime
//
//  Created by RYAN CHRISTENSEN on 1/5/15.
//  Copyright (c) 2015 RYAN CHRISTENSEN. All rights reserved.
//

import Foundation
import UIKit

class Tweet {
  var text : String
  var userName : String
  var tweetImage : String?
  var faveCount : String?
  var tweetID : String
  var image : UIImage?
  var screenName : String?
  
  init (_ jsonDictionary : [String : AnyObject]){
    self.text = jsonDictionary["text"] as String
    let userDictionary = jsonDictionary["user"] as [String : AnyObject]
    self.userName = userDictionary["name"] as String
    self.tweetImage = userDictionary["profile_image_url"] as String?
    self.tweetID = jsonDictionary["id_str"] as String
    
  }
  
  func updateWithInfo(infoDictionary : [String : AnyObject]) {
    //println(infoDictionary)
    let faveNumber = infoDictionary["favorite_count"] as? Int
    self.faveCount = "Favorites \(faveNumber!)"
  }
  
  func updateUserHistory(userTweetDictionary : [String : AnyObject]) {
    let userScreenName = userTweetDictionary["screen_name"] as? String?
    self.screenName = "\(userScreenName)"
  }
}