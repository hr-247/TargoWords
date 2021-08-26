//
//  jobDetailModal.swift
//  TolkApp
//
//  Created by sanganan on 6/17/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import Foundation
//
//struct jobDetailsModal : Codable {
//
//    var profileDetails : jobDetailModal?
//
//
//    enum CodingKeys: String, CodingKey {
//
//        case profileDetails = "profileDetails"
//
//    }
//}

struct jobDetailModal : Codable {
 
    var Success : Int?
    var job : jobDetailList?
   var translatedDoc : TranslatedDocModal?
    
    enum CodingKeys: String, CodingKey {
        
        case Success = "Success"
        case job = "job"
      case translatedDoc = "translatedDoc"
    }
}
struct jobDetailList : Codable
{
    var jobServiceType : Int? = 5000
    var jobType : Int? = Int()
    var needSwormIntepretor = false
    var jobStatus : Int?
    var needStamps = false
    var noOfWords : Int? = nil
    var noOfPages : Int? = nil
    var pinCode : Int? = nil
    var finalNoOfWords : Int? = nil
    var finalNoOfPages : Int? = nil
    var finalCallDuration : Int? = nil
    var _id : String? = ""
    var organization : String? = ""
    var jobDate : Int?
    var category : catListModal? = catListModal()
    var email : String? = ""
    var jobDescription :  String? = ""
    var userCreatedBy : CreatedbyModal = CreatedbyModal()
    var address : String? = ""
    var sourceLanguage  : SourceLang? = SourceLang()
    var destinationLanguage : DestinationLang? = DestinationLang()
    var contactPerson : String? = ""
    var converationManager : String? = ""
    var telephone : String? = ""
    var duration : Int? = nil
    var jobNumber : Int?
    var createdTime : Int?
    var documents : [uploadDocModal]?
    var finalBill : String?
    var assignedTo : assignedToModal?
    var acceptedBy : assignedToModal?
    var isUrgentJob : Bool?
    
//    init()
//    {
//         jobServiceType = 5000
//         jobType = nil
//         needSwormIntepretor = false
//         jobStatus = nil
//         needStamps = false
//         noOfWords = nil
//         noOfPages = nil
//         jobDate = nil
//         address = ""
//         duration = nil
//         sourceLanguage  = SourceLang()
//         organization = ""
//         destinationLanguage = DestinationLang()
//         category = catListModal()
//         contactPerson = ""
//         converationManager = ""
//         email = ""
//         jobDescription = ""
//         jobNumber = nil
//         telephone = ""
//         createdTime = nil
//  //       service = ""
//         documents = [uploadDocModal]()
//  
//    }
    
    
    enum CodingKeys: String, CodingKey{
        
        case jobServiceType = "jobServiceType"
        case jobType = "jobType"
        case needSwormIntepretor  = "needSwormIntepretor"
        case jobStatus = "jobStatus"
        case needStamps = "needStamps"
        case noOfWords = "noOfWords"
        case noOfPages = "noOfPages"
        case pinCode = "pinCode"
        case finalNoOfWords = "finalNoOfWords"
        case finalNoOfPages = "finalNoOfPages"
        case finalCallDuration = "finalCallDuration"
        case _id = "_id"
        case jobDate = "jobDate"
        case address = "address"
        case duration = "duration"
        case sourceLanguage  = "sourceLanguage"
        case organization = "organization"
        case destinationLanguage = "destinationLanguage"
        case category = "category"
        case contactPerson = "contactPerson"
        case converationManager = "converationManager"
        case telephone = "telephone"
        case email = "email"
        case jobDescription =  "jobDescription"
        case userCreatedBy =  "userCreatedBy"
        case jobNumber = "jobNumber"
        case createdTime = "createdTime"
        case documents = "documents"
        case finalBill = "finalBill"
        case assignedTo = "assignedTo"
        case acceptedBy = "acceptedBy"
        case isUrgentJob = "isUrgentJob"
        
    }
}





struct uploadDocModal : Codable
{
    var documentTitle : String?
    var _id : String?
    var documentUrl : String?
    
    enum CodingKeys: String, CodingKey {
        case documentTitle = "documentTitle"
        case _id = "_id"
        case documentUrl = "documentUrl"
    }
}
struct uploadDocuments : Codable, Equatable
{
    var documentTitle : String?
    var documentUrl : String?
    
    enum CodingKeys: String, CodingKey {
        case documentTitle = "documentTitle"
        case documentUrl = "documentUrl"
    }
}
struct assignedToModal : Codable
{
    var _id : String? = ""
    var name : String? = ""
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case name = "name"
        
    }
}

struct CreatedbyModal : Codable
{
    var _id : String? = ""
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        
    }
}

struct TranslatedDocModal : Codable
{
    var documents : [uploadDocModal]?
    
    enum CodingKeys: String, CodingKey {
        case documents = "documents"
        
    }
}
