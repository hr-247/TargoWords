//
//  NotificationsListModal.swift
//  TolkApp
//
//  Created by saurav sinha on 18/06/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

struct NotificationsListModal : Codable {
    let Success : Int?
    let Message : String?
    let notificationList : [NotificationList]?
    
    enum CodingKeys: String, CodingKey {
        
        case Success = "Success"
        case Message = "Message"
        case notificationList = "notificationList"
    }
    
}

struct NotificationList : Codable {
    let notificationType : Int?
     let createdTime : Int?
    //    let isActive : Bool?
    let _id : String?
  //  let user : String?
    let secondUser : SecondUser?
    let job : Job?
    let note : String?
    //  let webLink : String?
    //   let createdTime : Int?
    // let __v : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case notificationType = "notificationType"
        //     case isActive = "isActive"
        case _id = "_id"
       // case user = "user"
        case secondUser = "secondUser"
        case job = "job"
        case note = "note"
        case createdTime = "createdTime"

        //   case webLink = "webLink"
        //     case createdTime = "createdTime"
        //     case __v = "__v"
    }
    
}

struct SecondUser : Codable {
    //    let location : LocationNotif?
    //    let lowestPrice : Int?
    //    let highestPrice : Int?
    //    let userType : Int?
    //    let isPhoneVerified : Bool?
    //    let userStatus : Int?
    //    let isEmailVerified : Bool?
    //    let profilePic : String?
    //    let isActive : Bool?
    let _id : String?
    let email : String?
    let pass : String?
    let phone : String?
    let name : String?
    let address : String?
    //    let createdTime : Int?
    //    let __v : Int?
    
    enum CodingKeys: String, CodingKey {
        
        //        case location = "location"
        //        case lowestPrice = "lowestPrice"
        //        case highestPrice = "highestPrice"
        //        case userType = "userType"
        //        case isPhoneVerified = "isPhoneVerified"
        //        case userStatus = "userStatus"
        //        case isEmailVerified = "isEmailVerified"
        //        case profilePic = "profilePic"
        //        case isActive = "isActive"
        case _id = "_id"
        case email = "email"
        case pass = "pass"
        case phone = "phone"
        case name = "name"
        case address = "address"
        //        case createdTime = "createdTime"
        //        case __v = "__v"
    }
    
}

struct Job : Codable {
    //    let location : LocationNotif?
    //    let jobServiceType : Int?
    //    let jobType : Int?
    //    let needSwormIntepretor : Bool?
    //    let jobStatus : Int?
    //    let needStamps : Bool?
    //    let noOfWords : Int?
    //    let noOfPages : Int?
    let _id : String?
    //    let address : String?
    //    let sourceLanguage : String?
    //    let organization : String?
    let jobDate : Int?
    //    let category : String?
    //    let contactPerson : String?
    //    let telephone : String?
    //    let email : String?
    //    let jobDescription : String?
    //    let destinationLanguage : String?
    //    let duration : Int?
    //    let converationManager : String?
    //    let jobNumber : Int?
    //    let documents : [String]?
    //    let assignedTo : String?
    
    enum CodingKeys: String, CodingKey {
        
        //        case location = "location"
        //        case jobServiceType = "jobServiceType"
        //        case jobType = "jobType"
        //        case needSwormIntepretor = "needSwormIntepretor"
        //        case jobStatus = "jobStatus"
        //        case needStamps = "needStamps"
        //        case noOfWords = "noOfWords"
        //        case noOfPages = "noOfPages"
        case _id = "_id"
        //        case address = "address"
        //        case sourceLanguage = "sourceLanguage"
        //        case organization = "organization"
        case jobDate = "jobDate"
        //        case category = "category"
        //        case contactPerson = "contactPerson"
        //        case telephone = "telephone"
        //        case email = "email"
        //        case jobDescription = "jobDescription"
        //        case destinationLanguage = "destinationLanguage"
        //        case duration = "duration"
        //        case converationManager = "converationManager"
        //        case jobNumber = "jobNumber"
        //        case documents = "documents"
        //        case assignedTo = "assignedTo"
    }
    
}


struct LocationNotif : Codable {
    let type : String?
    let coordinates : [Double]?
    
    enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case coordinates = "coordinates"
    }
    
}

