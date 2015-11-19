//
//  Post.swift
//  Chiller
//
//  Created by Michael Valdez on 11/19/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation


class Post {
    var name: String!
    var title: String!
    var body: String!
    var img: UIImage!
    
    init(name: String!, body: String? = nil, title: String!,  image: UIImage) {
        self.name = name
        self.title = title
        self.body = body
        self.img = image
    }
}