//
//  DocDetailVC.swift
//  RefferingPhysicians
//
//  Created by Mike Gerdes on 2/3/15.
//  Copyright (c) 2015 Virginia Mason Medical Center. All rights reserved.
//

import UIKit
import CoreData

class DocDetailVC:UIViewController {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var medsvc: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var favSwitch: UISwitch!
    
    var docName: String = ""
    var docMedSvc: String = ""
    var docPhone: String = ""
    var docAddress: String = ""
    var docEmail: String = ""
    var docNpi: String = ""
    var urlString: String = ""
    var docImg:UIImage?
    var physicians = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = docName
        medsvc.text = docMedSvc
        phone.text = docPhone
        address.text = docAddress
        email.text = docEmail
        image.image = docImg
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //CORE DATA
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //check if physician is favorite
        var error: NSError?
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Physician")
        
        fetchRequest.predicate = NSPredicate(format: "npi == %@",docNpi)
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            //npi should be unique, any result will be true
            if(results.count > 0) {
                println("Favorite On!")
                favSwitch.setOn(true, animated: true)
            }
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
   
    @IBAction func favToggle(sender: AnyObject) {
        if favSwitch.on {
            println("ON")
            saveFavorite()
        } else {
            println("OFF")
            removeFavorite()
        }
    }

    
    func saveFavorite() {
        println("Save Favorite")
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("Physician",
            inManagedObjectContext:
            managedContext)
        
        let physician = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
        physician.setValue(docNpi, forKey: "npi")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }  
        //5
        physicians.append(physician)
    }
    
    func removeFavorite() {
        println("Removing Favorite")
        var error: NSError?
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Physician")
        fetchRequest.predicate = NSPredicate(format: "npi == %@",docNpi)
        fetchRequest.includesSubentities = false
        fetchRequest.returnsObjectsAsFaults = false
        let fetchedResults =
        context.executeFetchRequest(fetchRequest,
            error: &error)
        
        //if let results = fetchedResults {
            //var res: NSManagedObject!
            for res in fetchedResults! {
                context.deleteObject(res as NSManagedObject)
            }
            context.save(nil)
        //}
    }
}
