//
//  GetBankDetaills.swift
//  TolkApp
//
//  Created by sanganan on 7/17/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

struct GetBankDetaills : Codable
{
    var Success : Int
    var Message : String
    var data : AccountModal?
    
    enum CodingKeys: String, CodingKey {
        
        case Success = "Success"
        case Message = "Message"
        case data = "data"
   
    }
}
    struct AccountModal : Codable
    {
        var accountNumber : String
        var name : String
        var swiftNumber : String
        var taxId : String
        
        init?() {
            return nil
        }
        
        enum CodingKeys: String, CodingKey {
             
             case accountNumber = "accountNumber"
             case name = "name"
             case swiftNumber = "swiftNumber"
             case taxId = "taxId"
        
         }
        
        
        
}
