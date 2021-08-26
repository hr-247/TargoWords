//
//  JobAtParticularDateModal.swift
//  TolkApp
//
//  Created by sanganan on 6/12/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
struct JobAtParticularDateModal : Decodable {
    var Success :  Int?
    var Message : String?
    var jobLists : [String?]
    
    
    init(
        Success :  Int?,
        Message : String?,
        jobLists : [String?]
        
    ) {
        self.Success = Success
        self.Message = Message
        self.jobLists = jobLists
    }
}
