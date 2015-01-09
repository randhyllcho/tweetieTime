// Playground - noun: a place where people can play

import UIKit

class Stack {
  var things = [Int]()
  
  func push(thing : Int) {
    self.things.append(thing)
  }
  
  func pop() -> Int? {
    if !self.things.isEmpty{
      let thing = self.things.last
      self.things.removeLast()
      return thing
    } else{
      return nil
    }
  }
  
  func peak() -> Int? {
    return self.things.last
    
  }
}
