//
//  Post.swift
//  Chiller
//
//  Created by Michael Valdez on 11/19/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import WebKit


class Post {
    var name: String!
    var title: String!
    var body: String!
    var img: UIImage!
    var chill: Bool!
    var burn: Bool!
    
    init(name: String!, body: String? = nil, title: String!,  image: UIImage!, chill: Bool!, burn: Bool!) {
        self.name = name
        self.title = title
        self.body = body
        self.img = image
        self.chill = chill.boolValue
        self.burn = burn.boolValue
    }
}