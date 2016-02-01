//
//  SearchPerson.swift
//  Chiller
//
//  Created by Michael Valdez on 12/11/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import WebKit

class SearchPerson {
    var userid : String!
    var username: String!
    var pic: String!
    init (userid : String!, username: String!, pic: String!) {
        self.username = username
        self.userid = userid
        self.pic = pic
    }
    
}