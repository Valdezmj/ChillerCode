//
//  FriendRequest.swift
//  Chiller
//
//  Created by Michael Valdez on 12/21/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation

struct FriendRequest {
    var username = String()
    var userid = String()
    var profilepic = String()
    init (userid : String!, username: String!, pic: String!) {
        self.username = username
        self.userid = userid
        self.profilepic = pic
    }
}