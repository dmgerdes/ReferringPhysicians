//
//  ConditionVC.swift
//  RefferingPhysicians
//
//  Created by Mike Gerdes on 2/9/15.
//  Copyright (c) 2015 Virginia Mason Medical Center. All rights reserved.
//

import UIKit

class ConditionVC: UITableViewController {
    var conditionArray = ["Cancer","Heart Failure"]
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
        return conditionArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("conditionCell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = conditionArray[indexPath.row]

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "docNamesSegue" {
            var theSelectedRow:String
            let docDetail = segue.destinationViewController as SearchByNameVC
            
            
            let indexPath = self.tableView.indexPathForSelectedRow()
            theSelectedRow = conditionArray[indexPath!.row]
            docDetail.filterType = 3
            docDetail.filterCondition = theSelectedRow
        }
    }

}
