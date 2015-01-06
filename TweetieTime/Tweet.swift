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
  
  init (_ JsonDictionary: [String : AnyObject]){
    self.text = JsonDictionary["text"] as String
    let userDictionary = JsonDictionary["user"] as [String : AnyObject]
    self.userName = userDictionary["name"] as String
    self.tweetImage = userDictionary["profile_image_url"] as String?
  }
}