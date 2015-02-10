//
//  LocationVC.swift
//  RefferingPhysicians
//
//  Created by Mike Gerdes on 2/9/15.
//  Copyright (c) 2015 Virginia Mason Medical Center. All rights reserved.
//

import UIKit

class LocationVC: UITableViewController {
    var locationArray = ["Bainbridge Island","Bellevue","Downtown Seattle","Federal Way","Issaquah","Kirkland","Lynnwood","Metropolitan Park West","Partner: EvergreenHealth Cardiology Care","University Village",]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("locCell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = locationArray[indexPath.row]

        return cell
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "docNamesSegue" {
            var theSelectedRow:String
            let docDetail = segue.destinationViewController as SearchByNameVC
            
            
            let indexPath = self.tableView.indexPathForSelectedRow()
            theSelectedRow = locationArray[indexPath!.row]
            docDetail.filterType = 1
            docDetail.filterLoc = theSelectedRow
        }
    }

}
