//
//  LanguagesModal.swift
//  TolkApp
//
//  Created by sanganan on 6/12/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
struct LanguagesModal : Codable {
    var Success : Int?
    var language : [LangsModal]?
    
     enum CodingKeys: String, CodingKey {

           case Success = "Success"
           case language = "language"
       }

    
}

struct  LangsModal : Codable {
    var _id : String?
    var language : String?
    
    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case language = "language"
    }

}
