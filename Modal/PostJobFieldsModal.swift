//
//  PostJobFieldsModal.swift
//  TolkApp
//
//  Created by sanganan on 6/13/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
struct IntrFieldsHelper {

        var jobTyp : Int? = Int()
        var jobDate : Int?
        var addr : String? = ""
        var locTyp : String? = ""
        var locCordinate : [Float?] = [Float]()
        var zipCd : String? = ""
        var duration : Int? = nil
        var organization : String? = ""
        var sourceLng : String? = ""
        var destLang : String? = ""
        var category : String? = ""
        var needSwormIntr : Bool = false
        var ContactPerson : String? = ""
        var converManager : String? = ""
        var email : String? = ""
        var telephNo : String? = ""
        var jobDsc : String? = ""
        var jobNo : Int? = Int()
        var remarks : String? = ""
        var jobServiceType : Int = 5000
        var needStamp : Bool = false
        var manyWords : Int? = nil
        var manyPages : Int? = nil
        var imageUrl : String? = String()
        var sourceLangName = ""
        var destinationlangNme = ""
        var categoryName = ""
        
        init()
            {
                self.jobTyp = 0
                self.jobDate = nil
                self.addr = ""
                self.locTyp = "Point"
                self.locCordinate = []
                self.zipCd = ""
                self.duration = nil
                self.organization = ""
                self.sourceLng = ""
                self.destLang = ""
                self.category = ""
                self.needSwormIntr = false
                self.ContactPerson = ""
                self.converManager = ""
                self.email = ""
                self.telephNo = ""
                self.jobDsc = ""
                self.jobNo = 0
                self.remarks = ""
                self.jobServiceType  = 5000
                self.needStamp = false
                self.manyWords = nil
                self.manyPages = nil
                self.imageUrl = ""
                self.sourceLangName = ""
                self.destinationlangNme = ""
                self.categoryName = ""

        
    }
    
    
}
