//
//  CheckNumberModal.swift
//  TolkApp
//
//  Created by sanganan on 6/11/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
struct  CheckNumberModal : Decodable {
    var Success : Int?
    var Message : String?
    var userDetail : userModal?
    
    init(
    Success : Int?,
    Message : String?,
    userDetail : userModal?
    ) {
        self.Success = Success
        self.Message = Message
        self.userDetail = userDetail
    }
}
