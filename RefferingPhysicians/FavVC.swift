//
//  FavVC.swift
//  RefferingPhysicians
//
//  Created by Mike Gerdes on 2/6/15.
//  Copyright (c) 2015 Virginia Mason Medical Center. All rights reserved.
//

import UIKit
import CoreData

class FavVC: UITableViewController {
    var favPhysicians = [Doc]()
    var imageCache = [String:UIImage] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get prototype
        var nib = UINib(nibName: "DocTableCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "docCell")
        
        getFavPhysicians()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getFavPhysicians() {
        var error: NSError?
        var corePhysicians = [NSManagedObject]()
        
        //fetch fav docs
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Physician")
        fetchRequest.includesSubentities = false
        fetchRequest.returnsObjectsAsFaults = false
        let fetchedResults = context.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            corePhysicians = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        //match with physicians loaded and store in favPhysicians
        var index = -1 as Int
        var strNpi: String
        for doc in corePhysicians {
            index = findDocByNpi(doc.valueForKey("npi") as String)
            if index >=  0 {
                favPhysicians.append(physicians[index])
            }
            index = -1
        }
    }
    
    func findDocByNpi(npi : String) -> Int {
        var foundIndex:Int = -1
        for (index, doc) in enumerate(physicians) {
            if(npi == doc.npi) {
                foundIndex = index
            }
        }
        //if let index = find(physicians,npi) {
        //    foundIndex = index
        //}
        return foundIndex
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat
    {
        return 82
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favPhysicians.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("docCell", forIndexPath: indexPath) as DocTableCell
        
        let doc = self.favPhysicians[indexPath.row]
        cell.docName.text = doc.name
        cell.medSvc.text = doc.medsvc
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        //get image
        let urlString = doc.img as String
        var image = self.imageCache[urlString]
        println(urlString)
        
        if( image == nil ) {
            // If the image does not exist, we need to download it
            var imgURL: NSURL = NSURL(string: urlString)!
            
            // Download an NSData representation of the image at the URL
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    image = UIImage(data: data)
                    
                    // Store the image in to our cache
                    self.imageCache[urlString] = image
                    dispatch_async(dispatch_get_main_queue(), {
                        if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                            cell.docImg.image = image
                            doc.imgObj = image
                        }
                    })
                }
                else {
                    println("Error: \(error.localizedDescription)")
                }
            })
            
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                    cell.docImg.image = image                }
            })
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("docDetailSegue", sender: tableView)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        println("segue")
        if segue.identifier == "docDetailSegue" {
            var theSelectedRow:Doc
            let docDetail = segue.destinationViewController as DocDetailVC

            let indexPath = self.tableView.indexPathForSelectedRow()
            theSelectedRow = favPhysicians[indexPath!.row]

            docDetail.docName = theSelectedRow.name
            docDetail.docMedSvc = theSelectedRow.medsvc
            docDetail.docPhone = theSelectedRow.phone
            docDetail.urlString = theSelectedRow.img
            docDetail.docImg = theSelectedRow.imgObj
            docDetail.docNpi = theSelectedRow.npi
            docDetail.docAddress = theSelectedRow.address
            docDetail.docEmail = theSelectedRow.email
            NSLog("detail seque")
        }
    }



}
