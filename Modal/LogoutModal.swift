//
//  LogoutModal.swift
//  TolkApp
//
//  Created by saurav sinha on 18/06/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

struct LogoutModal : Codable {
    let success : Int?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case success = "Success"
        case message = "Message"
    }

}
