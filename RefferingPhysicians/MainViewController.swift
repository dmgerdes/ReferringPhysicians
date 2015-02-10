//
//  MainViewController.swift
//  RefferingPhysicians
//
//  Created by Mike Gerdes on 1/28/15.
//  Copyright (c) 2015 Virginia Mason Medical Center. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    @IBOutlet weak var lblWelcomeDoc: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get docs for app
        getPhysicians()
        
        //title page
        lblWelcomeDoc.text = "Welcome Dr. " + session.getUsersFullName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getPhysicians() {
        
        //pretend like i ran a query to get docs from web service
        physicians = [
            Doc(name:"Aboulafia, David",
                medsvc:"Oncology",
                phone:"(206)341-1111",
                img:"Aboulafia,David08color.jpg",
                npi:"456",
                address:"1100 Ninth Ave. Seattle, WA 98101",
                email:"david.aboulafia@virginiamason.org"),
            Doc(name:"Fellows, Chris",
                medsvc:"Cardiology",
                phone:"(206)341-1111",
                img:"Fellows,Christopher02color.jpg",
                npi:"123",
                address:"1100 Ninth Ave. Seattle, WA 98101",
                email:"christopher.fellows@virginiamason.org"),
            Doc(name:"Dipboye, Keith",
                medsvc:"Internal Medicine",
                phone:"(206)583-2299",
                img:"Dipboye,%20Keith.jpg",
                npi:"111",
                address:"1100 Ninth Ave. Seattle, WA 98101",
                email:"keith.dipboye@virginiamason.org"),
            Doc(name:"Duze, Nkeiruka",
                medsvc:"Internal Medicine",
                phone:"(206)583-2299",
                img:"Duze,%20Nkeiruka%2007%20color.jpg",
                npi:"222",
                address:"1100 Ninth Ave. Seattle, WA 98101",
                email:"nkeiruka.duze@virginiamason.org"),
            Doc(name:"Lee, Grace",
                medsvc:"Endocrinology",
                phone:"(206)583-2299",
                img:"Lee,%20Grace%2012.jpg",
                npi:"333",
                address:"1100 Ninth Ave. Seattle, WA 98101",
                email:"Grace.lee@virginiamason.org"),
            Doc(name:"Lord, James",
                medsvc:"Gastroenterology",
                phone:"(206)223-2319",
                img:"Lord,James%2010.jpg",
                npi:"444",
                address:"1100 Ninth Ave. Seattle, WA 98101",
                email:"james.lord@virginiamason.org"),
            Doc(name:"Nielsen, Scott",
                medsvc:"Neurology",
                phone:"(206)341-0420",
                img:"Nielsen,%20Scott.jpg",
                npi:"555",
                address:"1100 Ninth Ave. Seattle, WA 98101",
                email:"scott.nielsen@virginiamason.org"),
            Doc(name:"Shors, Heidi",
                medsvc:"Orthopedics",
                phone:"(206)223-7530",
                img:"Shors,%20Heidi%2007%20color.jpg",
                npi:"666",
                address:"1100 Ninth Ave. Seattle, WA 98101",
                email:"heidi.shors@virginiamason.org")]
        
    }
}