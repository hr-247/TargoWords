//
//  PostJobModal.swift
//  TolkApp
//
//  Created by sanganan on 6/12/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
struct PostJobModal : Codable
{
    var Success : Int?
    var Message : String?
    var createdjob : createdJobModl?
    
    enum CodingKeys: String, CodingKey {

    case Success = "Success"
    case  Message = "Message"
    case createdjob = "createdjob"
    
}
}
struct createdJobModl : Codable
{
    var _id : String?
    
    enum CodingKeys: String, CodingKey {

    case _id = "_id"
    
    }
    
}
