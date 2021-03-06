//
//  SearchPhysicianVC.swift
//  RefferingPhysicians
//
//  Created by Mike Gerdes on 1/29/15.
//  Copyright (c) 2015 Virginia Mason Medical Center. All rights reserved.
//

import UIKit

class SearchByNameVC: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate{
    var filterType:Int = 0 //0 = all, 1 = loc, 2 = medsvc, 3 = condition
    var filterMedSvc:String = ""
    var filterLoc:String = ""
    var filterCondition:String = ""
    var filteredPhysicians = [Doc]()
    var tempPhysicians = [Doc]()
    var imageCache = [String:UIImage] ()
    @IBOutlet var docTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        println(filterType)
        println(filterMedSvc)
        
        //register custom cell
        var nib = UINib(nibName: "DocTableCell", bundle: nil)
        self.searchDisplayController!.searchResultsTableView.registerNib(nib, forCellReuseIdentifier: "docCell")
        self.tableView.registerNib(nib, forCellReuseIdentifier: "docCell")
        
        if(filterType != 0) {
            buildTempPhysicians()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat {
        return 82
    }
    
    func buildTempPhysicians() {
        if(filterType == 2) {
            for doc in physicians {
                if doc.medsvc == filterMedSvc {
                    tempPhysicians.append(doc)
                }
            }
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(filterType)
        
        if(tableView == self.searchDisplayController!.searchResultsTableView) {
            return self.filteredPhysicians.count
        } else if (filterType != 0 ) {
            return tempPhysicians.count
        } else {
            return physicians.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("docCell") as DocTableCell
    
        
        //check which array should be displayed
        var doc:Doc
        if(tableView == self.searchDisplayController!.searchResultsTableView) {
            doc = self.filteredPhysicians[indexPath.row]
        } else if (filterType != 0 ) {
            doc = tempPhysicians[indexPath.row]
        } else {
            doc = physicians[indexPath.row]
        }
        
        cell.docName.text = doc.name
        cell.medSvc.text = doc.medsvc
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        //get image
        let urlString = doc.img as String
        var image = self.imageCache[urlString]
        println(urlString)
        
        if( image == nil ) {
            println("Image Not Cached")
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
            println("Image Cached")
            dispatch_async(dispatch_get_main_queue(), {
                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                    cell.docImg.image = image
                }
            })
        }
            
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("docDetailSegue", sender: tableView)
    }
    
    // MARK - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "docDetailSegue" {
            var theSelectedRow:Doc
            let docDetail = segue.destinationViewController as DocDetailVC
            
            if self.searchDisplayController!.active {
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()
                theSelectedRow = self.filteredPhysicians[indexPath!.row]
            } else if (filterType != 0 ) {
                let indexPath = self.tableView.indexPathForSelectedRow()
                theSelectedRow = tempPhysicians[indexPath!.row]
            } else {
                let indexPath = self.tableView.indexPathForSelectedRow()
                theSelectedRow = physicians[indexPath!.row]
            }

            docDetail.docName = theSelectedRow.name
            docDetail.docMedSvc = theSelectedRow.medsvc
            docDetail.docPhone = theSelectedRow.phone
            docDetail.urlString = theSelectedRow.img
            docDetail.docImg = theSelectedRow.imgObj
            docDetail.docNpi = theSelectedRow.npi
            docDetail.docAddress = theSelectedRow.address
            docDetail.docEmail = theSelectedRow.email        }
    }


    
    
    // MARK: UISearchDisplayController
    
    func filterPhysicianSearch(searchText:String) {
        //filter docs
        self.filteredPhysicians = physicians.filter({(doc:Doc) -> Bool in
            let stringMatch = doc.name.rangeOfString(searchText)
            
            return stringMatch != nil
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterPhysicianSearch(searchString)
        return true
    }
}