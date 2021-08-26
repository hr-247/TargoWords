//
//  ApprovedDocModal.swift
//  TolkApp
//
//  Created by sanganan on 6/14/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
struct approvedDocModal : Decodable
{
    var Success : Int?
    var Message : String?
  //  var result :
    
    enum CodingKey : String{
        case Success = "Success"
        case Message = "Message"
    }
}
