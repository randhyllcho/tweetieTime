//
//  NetworkController.swift
//  TweetieTime
//
//  Created by RYAN CHRISTENSEN on 1/7/15.
//  Copyright (c) 2015 RYAN CHRISTENSEN. All rights reserved.
//

import Foundation
import Social
import Accounts

class NetworkController {
  
  var twitterAccount : ACAccount?
  
  init() {
    
  }
  
  func fetchHomeTimeline(completionHandler : ( [Tweet]? , String?) -> ()) {
    
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
                var tweets = [Tweet]()
                for object in jsonArray {
                  if let jsonDictionary = object as? [String : AnyObject] {
                    let tweet = Tweet(jsonDictionary)
                    tweets.append(tweet)
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completionHandler(tweets,nil)
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
    

    
  }
}

