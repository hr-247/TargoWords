//
//  CreateUserModal.swift
//  TolkApp
//
//  Created by sanganan on 6/12/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
struct CreateUserModal : Decodable {
    var Success : Int?
    var Message : String?
    var createdUser : userModal?
    var paymentProfileId : String?
    
    enum CodingKey : String
    {
        case Success = "Success"
        case Message = "Message"
        case createdUser = "createdUser"
        case paymentProfileId = "paymentProfileId"

    }
}
struct userModal : Decodable
{
    var _id : String?
    var email : String?
    var pass : String?
    var phone : String?
    var name : String?
    var userType : Int?
    var userStatus : Int?
    var paymentProfileId : String?
    
    enum CodingKey : String
    {
        case _id = "_id"
        case email = "email"
        case pass = "pass"
        case phone = "phone"
        case name = "name"
        case userType = "userType"
        case userStatus = "userStatus"
        case paymentProfileId = "paymentProfileId"
        
    }
    
}
