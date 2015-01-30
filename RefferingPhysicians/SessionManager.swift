//
//  sessionManager.swift
//  RefferingPhysicians
//
//  Created by Mike Gerdes on 1/29/15.
//  Copyright (c) 2015 Virginia Mason Medical Center. All rights reserved.
//

import Foundation

class SessionManager {
    
    var fullName:String = ""
    var address: String = ""
    var phone: String = ""
    
    
    func setFullName (newFullName:String) {
        fullName = newFullName
    }
    
    func getUsersFullName() ->String {
        return fullName
    }
    
    func setAddress (newAddress:String) {
        address = newAddress
    }
    
    func getAddress() ->String {
        return address
    }
    
    func setPhone (newPhone:String) {
        phone = newPhone
    }
    
    func getPhone() ->String {
        return phone
    }
}