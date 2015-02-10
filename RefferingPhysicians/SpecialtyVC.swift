//
//  SpecialtyVC.swift
//  RefferingPhysicians
//
//  Created by Mike Gerdes on 2/9/15.
//  Copyright (c) 2015 Virginia Mason Medical Center. All rights reserved.
//

import UIKit

class SpecialtyVC: UITableViewController {
    var specialtyArray = ["Cardiology","Endocrinology","Gastroenterology","Internal Medicine","Neurology","Oncology","Orthopedics"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialtyArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("specialtyCell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel?.text = specialtyArray[indexPath.row]
        
        return cell
    }
/*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("docNamesSegue", sender: tableView)
    }
*/
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "docNamesSegue" {
            var theSelectedRow:String
            let docDetail = segue.destinationViewController as SearchByNameVC
        

            let indexPath = self.tableView.indexPathForSelectedRow()
            theSelectedRow = specialtyArray[indexPath!.row]
            docDetail.filterType = 2
            docDetail.filterMedSvc = theSelectedRow
        }
    }


}
