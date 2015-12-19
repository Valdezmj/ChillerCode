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
    let credentials = NSUserDefaults()
    
    @IBOutlet weak var _na: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization code
        let credentials = NSUserDefaults()
    }    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
