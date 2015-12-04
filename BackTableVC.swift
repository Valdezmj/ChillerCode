//
//  BackTableVC.swift
//  Chiller
//
//  Created by Michael Valdez on 11/3/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation

class BackTableVC: UITableViewController {
    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["IceBox"]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row];
        return cell
    }
}