//
//  UserType&LangModal.swift
//  TolkApp
//
//  Created by sanganan on 6/14/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
struct userTypeLangModal : Codable
{
        var Success : Int?
        var Message : String?
    
   enum CodingKeys: String, CodingKey {

        case Success = "Success"
        case Message = "Message"
    }
        
        
    }
    

struct userTypeModal : Decodable
    {
    var type : Int?
    var _id : String?
    var user : String?
    var fromLanguage : String?
    var toLanguage : String?
    
    
    init(
    
        type : Int?,
       _id : String?,
         user : String?,
         fromLanguage : String?,
        toLanguage : String?
    ) {
        self.type = type
        self._id = _id
        self.user = user
        self.fromLanguage = fromLanguage
        self.toLanguage = toLanguage
    }
}
