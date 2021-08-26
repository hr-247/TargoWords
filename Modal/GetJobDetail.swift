//
//  GetJobDetail.swift
//  TolkApp
//
//  Created by sanganan on 6/10/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

struct GetJobDetailModal : Codable
{
    var Success : Int?
    var  Message : String?
    var jobLists : [JobList]?
    var urgentJobLists : [UrgentJob]?
    
  // var job : JobList?
    
   enum CodingKeys: String, CodingKey {

        case Success = "Success"
        case  Message = "Message"
        case jobLists = "jobLists"
     case urgentJobLists = "urgentJobLists"
     //   case job = "job"
    }
}

struct UrgentJob : Codable {
    var job : JobList?
    enum CodingKeys: String, CodingKey {

        case job = "job"
    }
    
}


struct JobList : Codable {
   // var location : Location?
  //  var jobServiceType : Int?
  var jobType : Int?
   // var needSwormIntepretor : Bool?
    var jobStatus : Int?
   // var needStamps : Bool?
    var noOfWords : Int?
//    var noOfPages : Int?
    var _id : String?
//    var userCreatedBy : String?
    var jobDate : Int?
    var address : String?
//    var zipCode : String?
    var duration : Int?
    var sourceLanguage  : SourceLang?
//    var organization : String?
    var destinationLanguage : DestinationLang?
//    var category : String?
//    var contactPerson : String?
//    var converationManager : String?
//    var email : String?
    //var telephone : String?
//    var jobDescription :  String?
    
    var isUrgentJob : Int?
    
    var jobNumber : Int?
 //   var remarks : String?
    var service : String?
//    var documents : [String]?
    
    enum CodingKeys: String, CodingKey {

            //case location = "location"
        //    case jobServiceType =  "jobServiceType"
            case jobType =  "jobType"
       //     case needSwormIntepretor = "needSwormIntepretor"
            case jobStatus = "jobStatus"
       //     case needStamps = "needStamps"
          case noOfWords = "noOfWords"
       //     case noOfPages = "noOfPages"
            case _id = "_id"
      //      case userCreatedBy = "userCreatedBy"
            case jobDate = "jobDate"
            case address = "address"
      //      case zipCode = "zipCode"
            case duration = "duration"
            case sourceLanguage = "sourceLanguage"
      //      case organization = "organization"
            case destinationLanguage = "destinationLanguage"
      //      case category = "category"
      //      case contactPerson = "contactPerson"
      //      case converationManager = "converationManager"
      //      case email = "email"
           // case telephone = "telephone"
      //      case jobDescription = "jobDescription"
            case jobNumber = "jobNumber"
     //       case remarks = "remarks"
            case service = "service"
      //      case documents = "documents"
    }

    
   
    }
    

struct Location : Codable
{
    var type : String?
    var coordinates : [Float]?
   
    enum CodingKeys: String, CodingKey {

        case type = "type"
        case  coordinates = "coordinates"
       
    }
    
}

struct SourceLang : Codable
{
    var _id : String? = ""
    var language : String? = ""
   
    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case  language = "language"
       
    }
    
    
}

struct DestinationLang : Codable
{
    var _id : String? = ""
    var language : String? = ""
   
    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case  language = "language"
       
    }
   
    
}





