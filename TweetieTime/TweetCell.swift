//
//  TweetCell.swift
//  TweetieTime
//
//  Created by RYAN CHRISTENSEN on 1/5/15.
//  Copyright (c) 2015 RYAN CHRISTENSEN. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

  @IBOutlet weak var userImageView: UIImageView!
  
  @IBOutlet weak var tweetLabel: UILabel!
  
  @IBOutlet weak var userNameLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.layoutIfNeeded()
    self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.width
  }


}
