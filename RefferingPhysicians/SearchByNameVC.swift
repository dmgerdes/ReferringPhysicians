//
//  SearchPhysicianVC.swift
//  RefferingPhysicians
//
//  Created by Mike Gerdes on 1/29/15.
//  Copyright (c) 2015 Virginia Mason Medical Center. All rights reserved.
//

import UIKit

class SearchByNameVC: UIViewController {
    var physician = [Doc]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.physician.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier:"searchCell")
        
        //cell details
        let doc = self.physician[indexPath.row]
        cell.textLabel?.text = doc.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func getPhysicians() {
        
        //pretend like i ran a query to get docs from web service
        self.physician = [Doc(name:"Fellow, Chris", medsvc:"Cardiology", phone:"(206)341-1111", img:"Fellows,Chrostopher02color.jpg",npi:"123"),
            Doc(name:"Aboulafia, David", medsvc:"Hematology/Oncology", phone:"(206)341-1111",img:"Aboulafia,David08color.jpg", npi:"456")]
        
    }
}