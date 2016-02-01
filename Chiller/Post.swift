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
    var img: String!
    var chill: Bool!
    var burn: Bool!
    var time: String!
    var comments: String!
    var pics: String!
    var videos: String!
    
    init(name: String!, body: String? = nil, title: String!,  image: String!, chill: Bool!, burn: Bool!, time: String!, comments: String!, pics: String!, videos: String!) {
        self.name = name
        self.title = title
        self.body = body
        self.img = image
        self.chill = chill.boolValue
        self.burn = burn.boolValue
        self.time = time
        self.comments = comments
        self.pics = pics
        self.videos = videos
    }
}