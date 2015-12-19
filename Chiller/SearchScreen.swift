//
//  SearchScreen.swift
//  Chiller
//
//  Created by Michael Valdez on 12/9/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import WebKit
import AlamofireImage
import Alamofire

class Search : UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var people = [SearchPerson]()
    var filteredPeople = [SearchPerson]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Right view did load!")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewWillAppear(animated: Bool) {
        let personOne = SearchPerson(userid: "3", username: "mikeyv", pic: "wfwefw")
        let personTwo = SearchPerson(userid: "3", username: "user two", pic: "wfwefw")
        let personThree = SearchPerson(userid: "3", username: "user five", pic: "wfwefw")
        people.append(personOne)
        people.append(personTwo)
        people.append(personThree)
    
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("Another cell")
        let reuseIdentifier = "SearchCell"
        var cell = self.tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! SearchCell!
        if cell == nil
        {
            cell = SearchCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        }
        cell.leftButtons = [MGSwipeButton(title: "Add", backgroundColor: UIColor.greenColor(), callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            
            return true
        })]
        let _p = people[indexPath.row]
        cell.leftSwipeSettings.transition = MGSwipeTransition.ClipCenter
        print("\(_p.username)")
        return cell
    }
 
    
}