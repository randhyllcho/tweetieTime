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
  var imageQueue = NSOperationQueue()
  
  init() {
    
  }
  
  func fetchHomeTimeline(completionHandler : ([Tweet]? , String?) -> ()) {
    
    let accountStore = ACAccountStore()
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
      if granted {
        let accounts = accountStore.accountsWithAccountType(accountType)
        if !accounts.isEmpty {
          self.twitterAccount = accounts.first as ACAccount?
          let requestURL = (string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
          let urlRequest = NSURL(string: requestURL)
          let twittertRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: urlRequest, parameters: nil)
          twittertRequest.account = self.twitterAccount
      
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
                  }
                  
                }
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  completionHandler(tweets,nil)
                })

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
  
  var faveCount = String?()
  
  func fetchTweetID(tweetId : String , completionHandler : ([String : AnyObject]? , String?) -> ()) {
   
    let idrequesteURL = (string: "https://api.twitter.com/1.1/statuses/show.json?id=\(tweetId)")
    let url = NSURL(string: idrequesteURL)
    let twitterIDRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: url!, parameters: nil)
    twitterIDRequest.account = twitterAccount

    twitterIDRequest.performRequestWithHandler { (data, response, error) -> Void in
      if error == nil {
        switch response.statusCode {
        case 200...299:
          println("This worked")
          if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String : AnyObject] {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completionHandler(jsonDictionary,nil)
            })
            
          }
        case 300...599:
          println("Not good buddy")

        default:
          println("Default fired!")
        }
      }
      
        }
       }
  
  func fetchUserTweetHistory(screenName: String, completionHandler : ([Tweet]? , String?) -> ()) {
    
    let historyRequestURL = (String: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(screenName)")
    let historyURL = NSURL(string: historyRequestURL)
    let twitterHistoryRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: historyURL, parameters: nil)
    twitterHistoryRequest.account = twitterAccount
    
    twitterHistoryRequest.performRequestWithHandler { (data, response, error) -> Void in
      if error == nil {
        switch response.statusCode {
        case 200...299:
          println("This worked")
          
          if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [AnyObject] {
            var tweetHistory = [Tweet]()
            for object in jsonArray {
              if let jsonDictionary = object as? [String : AnyObject] {
                let tweetish = Tweet(jsonDictionary)
                tweetHistory.append(tweetish)
              }
              
            }
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              completionHandler(tweetHistory,nil)
            })
            
          }

        default:
          println("Default Fired!!!")
        }
      }
    }
    
  }
  
  func fetchImageForTweet(tweet : Tweet, completionHandler: (UIImage?) -> ()){
    
    if let imageURL = NSURL(string: tweet.tweetImage!) {
      self.imageQueue.addOperationWithBlock { () -> Void in
        if let imageData = NSData(contentsOfURL: imageURL){
          tweet.image = UIImage(data: imageData)
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(tweet.image)
          })
        }
     }
    }
  }
  }


