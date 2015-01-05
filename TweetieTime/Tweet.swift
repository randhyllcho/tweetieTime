//
//  Tweet.swift
//  TweetieTime
//
//  Created by RYAN CHRISTENSEN on 1/5/15.
//  Copyright (c) 2015 RYAN CHRISTENSEN. All rights reserved.
//

import Foundation


class Tweet {
  var text : String
  init (_ JsonDictionary: [String : AnyObject]){
    self.text = JsonDictionary["text"] as String
  }
}