//
//  CategoryModal.swift
//  TolkApp
//
//  Created by sanganan on 6/12/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

struct  CategoryModal : Codable {
    var Success : Int?
    var Message : String?
    var catlist : [catListModal]?
   enum CodingKeys: String, CodingKey {

          case Success = "Success"
          case  Message = "Message"
          case catlist = "catlist"
   
      }
}
struct catListModal : Codable {
    var _id : String? = ""
    var name : String? = ""
     enum CodingKeys: String, CodingKey {

            case _id = "_id"
            case  name = "name"
         
        }
   
}
