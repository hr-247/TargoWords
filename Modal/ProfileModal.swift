//
//  ProfileModal.swift
//  TolkApp
//
//  Created by sanganan on 6/16/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
//struct ProfileModal : Decodable {
//    var Success : Int?
//    var profile : profModal?
//    var job : profModal?
//
//
//    init(
//    Success : Int?,
//   profile : profModal?,
//   job : profModal?
//    ) {
//        self.Success = Success
//        self.profile = profile
//        self.job = job
//    }
//}
//struct profModal  : Decodable {
//    var userType : Int?
//    var userStatus : Int?
//
//
//    init(
//    userType : Int?,
//    userStatus : Int?
//
//    ) {
//        self.userType = userType
//        self.userStatus = userStatus
//    }
//}

//struct ProfileModal : Codable {
//    let success : Int?
//    let profile : Profile?
//
//    enum CodingKeys: String, CodingKey {
//
//        case success = "Success"
//        case profile = "profile"
//    }
//
//}
//




struct ProfileModal : Codable {
    let Success : Int?
    let userDetail : UserDetail?
    let paymentDetail : [cardModal]
    
    enum CodingKeys: String, CodingKey {
        
        case Success = "Success"
        case userDetail = "userDetail"
        case paymentDetail = "paymentDetail"
    }
    
}

struct UserDetail : Codable {
    let _id : String?
    let location : Location?
    let lowestPrice : Int?
    let highestPrice : Int?
    let userType : Int?
    let isPhoneVerified : Bool?
    let userStatus : Int?
    let rejectionReason : String?
    let isEmailVerified : Bool?
    let profilePic : String?
    let isActive : Bool?
    var email : String?
    let pass : String?
    var phone : String?
    var name : String?
    var address : String?
    let createdTime : Int?
    let __v : Int?
    let city : String?
    let country : String?
    let state : String?
    let zip : String?
    var perHourRate : Int?
    var swormIntepretor : Bool?
    var perWordPrice : Float?
    var langauges : [UserLangauage]?
    var documents : [Documents]?

    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case location = "location"
        case lowestPrice = "lowestPrice"
        case highestPrice = "highestPrice"
        case userType = "userType"
        case isPhoneVerified = "isPhoneVerified"
        case userStatus = "userStatus"
        case rejectionReason = "rejectionReason"
        case isEmailVerified = "isEmailVerified"
        case profilePic = "profilePic"
        case isActive = "isActive"
        case email = "email"
        case pass = "pass"
        case phone = "phone"
        case name = "name"
        case address = "address"
        case createdTime = "createdTime"
        case __v = "__v"
        case city = "city"
        case country = "country"
        case state = "state"
        case zip = "zip"
        case perHourRate = "perHourRate"
        case perWordPrice = "perWordPrice"
        case langauges = "langauges"
        case documents = "documents"
        case swormIntepretor = "swormIntepretor"

    }
}

struct UserLangauage : Codable {
    let fromLanguage : LangsModal?
    let toLanguage : LangsModal?
    let type : Int?

    enum CodingKeys: String, CodingKey {
        
        case fromLanguage = "fromLanguage"
        case toLanguage = "toLanguage"
        case type = "type"

    }
    
}





struct LocationProfile : Codable {
    let type : String?
    let coordinates : [Int]?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case coordinates = "coordinates"
    }
    
}

struct Documents : Codable {
    let docUrl : String?
    let user : String?
    let docType : DocType?
    
    enum CodingKeys: String, CodingKey {
        case docUrl = "docUrl"
        case user = "user"
        case docType = "docType"
    }
    
}

struct DocType : Codable {
    let _id : String?
        enum CodingKeys: String, CodingKey {
        case _id = "_id"
    }
    
}
