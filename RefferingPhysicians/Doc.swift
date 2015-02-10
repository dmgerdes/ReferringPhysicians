//
//  Doc.swift
//  RefferingPhysicians
//
//  Created by Mike Gerdes on 1/30/15.
//  Copyright (c) 2015 Virginia Mason Medical Center. All rights reserved.
//

import Foundation
import UIKit

var physicians = [Doc]()

class Doc:NSObject {
    var name: String
    var medsvc: String
    var phone: String
    var img: String
    var npi: String
    var imgObj:UIImage?
    var address:String
    var email: String
    
    init (name:String, medsvc:String,phone:String,img:String,npi:String,address:String,email:String) {
        self.name = name
        self.medsvc = medsvc
        self.phone = phone
        self.img = "https://www.virginiamason.org/images/providers/" + img
        self.npi = npi
        self.address = address
        self.email = email
        
        super.init()
    }
    
}