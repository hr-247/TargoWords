//
//  UploadDocModal.swift
//  TolkApp
//
//  Created by sanganan on 6/14/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
struct UploadDocModal : Codable {
    var Success : Int?
    var Message : String?
    
    enum CodinKey : String {
        case Success = "Success"
        case Message = "Message"
    }
 
}
struct uploadedDocModal : Codable
{
    var _id : String?
    var docType : String?
    var docUrl : String?
    
    enum CodingKey : String {
        case _id = "_id"
        case docType = "docType"
        case docUrl = "docUrl"
    }
    
}
