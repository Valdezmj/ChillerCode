//
//  PostTableViewCell.swift
//  Chiller
//
//  Created by Michael Valdez on 11/18/15.
//  Copyright © 2015 MK. All rights reserved.
//

import UIKit
import AlamofireImage
class PostTableViewCell: MGSwipeTableCell {
    

    @IBOutlet weak var postTime: UILabel!
    @IBOutlet weak var chillTag: UILabel!
    @IBOutlet weak var postname: UILabel!
    @IBOutlet weak var postBody: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    let credentials = NSUserDefaults()
    
    override func awakeFromNib() {
        super.awakeFromNib()
         //Initialization code
        let credentials = NSUserDefaults()
        let url = NSURL(string: "http://192.168.1.121/profile_pic/\(credentials.objectForKey("username")!)/profile.png")!
        let blankImage = UIImage(named: "")
        let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 100, height: 100));
        avatar.af_setImageWithURL(url, placeholderImage: blankImage, filter: filter, imageTransition: UIImageView.ImageTransition.CrossDissolve(1))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
