//
//  PostCommentCell.swift
//  chillur
//
//  Created by Michael Valdez on 1/20/16.
//  Copyright © 2016 MK. All rights reserved.
//

import Foundation

class PostCommentCell: UITableViewCell {
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var name: UILabel!
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
