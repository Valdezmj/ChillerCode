//
//  PostDetailsCellClass.swift
//  chillur
//
//  Created by Michael Valdez on 1/20/16.
//  Copyright © 2016 MK. All rights reserved.
//

import Foundation

class PostDetailsCellClass {
    var name: String!
    var body: String!
    var img: String!
    var time: String!
    var pic: String!
    var video: String!
    
    init(name: String!, body: String? = nil,image: String!, time: String!, pics: String!, videos: String!) {
        self.name = name
        self.body = body
        self.img = image
        self.time = time
        self.pic = pics
        self.video = videos
    }
}