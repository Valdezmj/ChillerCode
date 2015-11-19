//
//  FriendSection.swift
//  Chiller
//
//  Created by Michael Valdez on 11/18/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import WebKit

class FriendSection : UIViewController, UITableViewDataSource, UITableViewDelegate {
    var posts = [Post]()

    @IBOutlet weak var postTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTable.delegate = self
        postTable.dataSource = self
        self.loadPosters()
    }
    
    func loadPosters() {
        let photo1 = UIImage(named: "user.png")
        let personOne = Post(name: "Michael", body: "text me for details 7206358528", title: "Part at my house", image: photo1!)
        let personTwo = Post(name: "Karlie", body: "just watching game of thrones with bay", title: "Netflix and chill", image: photo1!)
        let personThree = Post(name: "Kyle", body: "text me if you're going", title: "Going to tracks tonight", image: photo1!)
        
        posts += [personOne, personTwo, personThree]
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostTableViewCell") as! PostTableViewCell
        
        let _post = posts[indexPath.row]
        
        // Configure the cell...
        cell.postname.text = _post.name
        cell.postBody.text = _post.body
        cell.postTitle.text = _post.title
        cell.avatar.image = _post.img
        
        
        return cell
    }
    
}