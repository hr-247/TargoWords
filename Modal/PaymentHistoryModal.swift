//
//  PaymentHistoryModal.swift
//  TolkApp
//
//  Created by sanganan on 7/3/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
struct PaymentHistoryModal : Codable {
    var Success : Int?
    var Message : String?
    var paymentList : [PaymentModal]
    
    enum CodingKey : String {
        case Success = "Success"
        case Message = "Message"
        case paymentList = "paymentList"
    }
}
    struct PaymentModal : Codable{
        var amountforTI : Float?
        var amountforJobCreator : Float?
        var type : String?
        var refund : Float?
        var job : JobModal?
        enum CodingKey : String {
            case amountforTI = "amountforTI"
            case amountforJobCreator = "amountforJobCreator"
            case type = "type"
            case refund = "refund"
            case job = "job"
        }
}
        struct JobModal : Codable{
            var jobServiceType : Int?
            var jobType : Int?
            var paymentStatus : String?
            var address : String?
            var duration : Int?
            var jobDate : Int?
            var jobNumber : Int?
            var finalNoOfWords : Int?
            
            enum CodingKey : String {
                case jobServiceType = "jobServiceType"
                case jobType = "jobType"
                case paymentStatus = "paymentStatus"
                case address = "address"
                case duration = "duration"
                case jobDate = "jobDate"
                case jobNumber = "jobNumber"
                case finalNoOfWords = "finalNoOfWords"

            }
}


// TI Payment Modal

//{
//    "jobType": 1002,
//    "finalNoOfWords": 0,
//    "finalNoOfPages": 0,
//    "finalCallDuration": 0,
//    "waitingTime": 0,
//    "tiPayment": 0,
//    "_id": "5f918cd53570030017973c28",
//    "jobDate": 1603374902,
//    "jobNumber": 10099
//}


struct PaymentTIModal : Codable {
    var Success : Int?
    var Message : String?
    var paymentList : [PaymentRecords]
    
    enum CodingKey : String {
        case Success = "Success"
        case Message = "Message"
        case paymentList = "paymentList"
    }
}

struct PaymentRecords : Codable{
        var jobType : Int?
        var finalNoOfWords : Int?
        var finalNoOfPages : Int?
        var finalCallDuration : Int?
        var waitingTime : Int?
    var tiPayment : Int?
    var _id : String?
    var jobDate : Int?
    var jobNumber : Int?
    
    
        enum CodingKey : String {
            case jobType = "jobType"
            case finalNoOfWords = "finalNoOfWords"
            case finalNoOfPages = "finalNoOfPages"
            case finalCallDuration = "finalCallDuration"
            case waitingTime = "waitingTime"
            case tiPayment = "tiPayment"
            case _id = "_id"
            case jobDate = "jobDate"
            case jobNumber = "jobNumber"

        }
}
