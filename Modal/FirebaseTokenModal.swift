//
//  FirebaseTokenModal.swift
//  TolkApp
//
//  Created by saurav sinha on 18/06/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

struct FirebaseTokenModal : Codable {
    let success : Int?
    let message : String?
    let token : Token?
    
    enum CodingKeys: String, CodingKey {
        
        case success = "Success"
        case message = "Message"
        case token = "token"
    }
    
}

struct Token : Codable {
    let deviceType : Int?
    let isactive : Bool?
    let updatedtime : Int?
    let _id : String?
    let userId : String?
    let fcmId : String?
    let oSVersion : String?
    let deviceName : String?
    let ipAddress : String?
    let createdTime : Int?
    let __v : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case deviceType = "deviceType"
        case isactive = "isactive"
        case updatedtime = "updatedtime"
        case _id = "_id"
        case userId = "userId"
        case fcmId = "fcmId"
        case oSVersion = "OSVersion"
        case deviceName = "deviceName"
        case ipAddress = "ipAddress"
        case createdTime = "createdTime"
        case __v = "__v"
    }
    
}

