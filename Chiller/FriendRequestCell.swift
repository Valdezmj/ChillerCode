//
//  FriendRequestCell.swift
//  Chiller
//
//  Created by Michael Valdez on 12/21/15.
//  Copyright © 2015 MK. All rights reserved.
//
import Foundation

class FriendRequestCell: MGSwipeTableCell {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
