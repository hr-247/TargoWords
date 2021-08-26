//
//  DefaultCardModal.swift
//  TolkApp
//
//  Created by sanganan on 8/26/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import Foundation
struct  DefaultCardModal : Codable {
    var Success  : Int?
    var Message  : String?
    var resp : SourceCardModal?
    
    enum CodingKey : String {
        case Success = "Success"
        case Message = "Message"
        case resp = "resp"
    }
    
}

struct SourceCardModal : Codable {
    var  default_source : String?
    
    enum CodingKey : String
    {
        case default_source = "default_source"
    }
    
}
