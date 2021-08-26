//
//  CreditCardDetailsModal.swift
//  TolkApp
//
//  Created by sanganan on 7/3/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
struct CreditCardDetailsModal : Codable {
    var Success : Int?
    var Message : String?
    var customer : customerModal?
    
    enum CodingKey : String
    {
        case Success = "Success"
        case Message = "Message"
        case customer = "customer"
      
    }
    
}
struct customerModal : Codable {
    var sources : sourcesModal?
    var default_source : String?

    enum CodingKey : String
    {
        case sources = "sources"
        case default_source = "default_source"

      
    }
}
struct sourcesModal : Codable {
    var data : [cardModal]
    
    enum CodingKey : String
    {
        case data = "data"
      
    }
}
struct cardModal : Codable {
    var id : String?
    var brand : String?
    var exp_month : Int?
    var exp_year : Int?
    var last4 : String?
   var name : String?
    
    enum CodingKey : String
    {
        case id = "id"
        case brand = "brand"
        case exp_month = "exp_month"
        case exp_year = "exp_year"
        case last4 = "last4"
       case name = "name"
    }
}
