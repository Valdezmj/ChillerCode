//
//  SearchCell.swift
//  Chiller
//
//  Created by Michael Valdez on 12/9/15.
//  Copyright © 2015 MK. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class SearchCell: MGSwipeTableCell {
    @IBOutlet weak var _pic: UIImageView!
    @IBOutlet weak var _name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
