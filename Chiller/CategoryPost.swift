//
//  PostTableViewCell.swift
//  Chiller
//
//  Created by Michael Valdez on 11/18/15.
//  Copyright © 2015 MK. All rights reserved.
//

import UIKit

class CategoryPost: UITableViewCell {
    
    @IBOutlet weak var postname: UILabel!
    @IBOutlet weak var postBody: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
