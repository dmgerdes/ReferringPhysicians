//
//  MainViewController.swift
//  RefferingPhysicians
//
//  Created by Mike Gerdes on 1/28/15.
//  Copyright (c) 2015 Virginia Mason Medical Center. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var lblDocsName: UILabel!
    var menuData = [
        "Search By Name",
        "Search By Location",
        "Search By Specialty",
        "Search By Condition",
        "Favorites"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblDocsName.text = session.getUsersFullName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //tableviewdatasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier:"searchCell")
        
        //cell details
        cell.textLabel?.text = menuData[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("Selected cell #\(indexPath.row)!")
        
        if(indexPath.row == 0) {
            //search by name
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextController = storyBoard.instantiateViewControllerWithIdentifier("searchByName") as SearchByNameVC
            self.presentViewController(nextController, animated:true, completion:nil)
        }
    }
}