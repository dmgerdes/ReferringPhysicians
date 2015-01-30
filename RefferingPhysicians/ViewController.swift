//
//  ViewController.swift
//  RefferingPhysicians
//
//  Created by Mike Gerdes on 1/28/15.
//  Copyright (c) 2015 Virginia Mason Medical Center. All rights reserved.
//

import UIKit
import CoreData

//create a new session to store latest data
var session = SessionManager()

class ViewController: UIViewController{

    
    @IBOutlet var lastName: UITextField!
    @IBOutlet var npi: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var checkBoxButton: UIButton!
    var isChecked:Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //main
        isChecked = false //eventually check prefs
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginClick(sender: UIButton) {
        //check if npi is valid
        var inLastName:NSString = lastName.text
        var inNPI:NSString = npi.text
            
        if ( inLastName.isEqualToString("") || inNPI.isEqualToString("") ) {
                
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter Last Name and NPI"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
            //for testing 
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let mainViewController = storyBoard.instantiateViewControllerWithIdentifier("main") as MainViewController
            self.presentViewController(mainViewController, animated:true, completion:nil)
        } else {
            
            var post:NSString = "?limit=1&offset=0&key1=last_name&op1=eq&value1=\(inLastName)&key2=npi&op2=eq&value2=\(inNPI)"
                
            NSLog("PostData: %@",post);
                
            var url:NSURL = NSURL(string: "http://www.bloomapi.com/api/search" + post)!
                
            var postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
                
            var postLength:NSString = String( postData.length )
                
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "GET"
            //request.HTTPBody = postData
            //request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //request.setValue("application/json", forHTTPHeaderField: "Accept")
                
                
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
            
            if ( urlData != nil ) {
                let res = response as NSHTTPURLResponse!;
                    
                NSLog("Response code: %ld", res.statusCode);
                    
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                        
                    NSLog("Response ==> %@", responseData);
                        
                    var error: NSError?
                    let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as NSDictionary
                    if error != nil {
                        // If there is an error parsing JSON, print it to the console
                        println("JSON Error \(error!.localizedDescription)")
                    }
                    let meta:AnyObject = jsonData["meta"]!
                    let rowCount = meta["rowCount"] as String
                    println(rowCount)
                    //let success:NSString = jsonData.valueForKey("rowCount") as NSString
                        
                    //[jsonData[@"success"] integerValue];
                        
                    //NSLog("Success: %ld", success);
                    
                    if(rowCount == "1")
                    {
                        NSLog("Login SUCCESS");
                        
                        //get users session info
                        if let result: AnyObject = jsonData["result"] {
                            for aResult in result as NSArray {
                                session.setFullName(aResult["last_name"] as String)
                            }
                        }
                        
                        NSLog("test")
                        //save core data
                        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        prefs.setObject(inLastName, forKey: "LASTNAME")
                        prefs.setObject(inNPI, forKey: "NPI")
                        prefs.synchronize()
                            
                        self.dismissViewControllerAnimated(true, completion: nil)
                            
                            
                        //load main storyboard
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let mainViewController = storyBoard.instantiateViewControllerWithIdentifier("main") as MainViewController
                        self.presentViewController(mainViewController, animated:true, completion:nil)
                    } else {
                        var error_msg:NSString
                            
                        if rowCount == "0" {
                            error_msg = "No Results Found"
                        } else {
                            error_msg = "Unknown Error"
                        }
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Log in Failed!"
                        alertView.message = error_msg
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                        
                    }
                        
                } else {
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed!"
                    alertView.message = "Connection Failed"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            } else {
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Connection Failure"
                if let error = reponseError {
                    alertView.message = (error.localizedDescription)
                }
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
    }
    
    @IBAction func checkBoxClick(sender: UIButton) {
        //Save user login or clear
        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if(isChecked == false) {
            checkBoxButton.setImage(UIImage(named: "checked_checkbox"), forState: UIControlState.Normal)
            isChecked = true        } else {
            checkBoxButton.setImage(UIImage(named: "unchecked_checkbox"), forState: UIControlState.Normal)
            isChecked = false
        }
        prefs.setBool(isChecked!, forKey: "SAVELOGIN")
    }
}

