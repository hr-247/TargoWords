//
//  ClassConst.swift
//  TolkApp
//
//  Created by sanganan on 5/19/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
class classConst : NSObject{
    
    static let interpArr = ["dateTimeK".localizableString(loc: Constant.lang),
                            "serviceK".localizableString(loc: Constant.lang),
                            "addressK".localizableString(loc: Constant.lang),
                            "durationK".localizableString(loc: Constant.lang),
                            "organisK".localizableString(loc: Constant.lang),
                            "sourLK".localizableString(loc: Constant.lang),
                            "destLK".localizableString(loc: Constant.lang),
                            "categK".localizableString(loc: Constant.lang),
                            "swornIK".localizableString(loc: Constant.lang),
                            "contPerK".localizableString(loc: Constant.lang),
                            "conversMK".localizableString(loc: Constant.lang),
                            "emailK".localizableString(loc: Constant.lang),
                            "teleNoK".localizableString(loc: Constant.lang),
                            "jobDscK".localizableString(loc: Constant.lang)
    ]
    
    static let transArr = ["deadlK".localizableString(loc: Constant.lang),
                           "delAddK".localizableString(loc: Constant.lang),
                           "organisK".localizableString(loc: Constant.lang),
                           "sourLK".localizableString(loc: Constant.lang),
                           "destLK".localizableString(loc: Constant.lang),
                           "nContPK".localizableString(loc: Constant.lang),
                           "emailK".localizableString(loc: Constant.lang),
                           "teleNoK".localizableString(loc: Constant.lang),
                           "manyPgesK".localizableString(loc: Constant.lang),
                           "manyWrdsK".localizableString(loc: Constant.lang),
                           "needStmpK".localizableString(loc: Constant.lang),
                           "addDocK".localizableString(loc: Constant.lang)
    ]
    
    
    static let rolesArr : [[String : Any]] = [["type" : "interK".localizableString(loc: Constant.lang), "id" : 1000],
                                              ["type" : "transK".localizableString(loc: Constant.lang), "id" : 1002],
                                              ["type" : "transNIntrKey".localizableString(loc: Constant.lang), "id" : 1003],
                                              ["type" : "jobCK".localizableString(loc: Constant.lang), "id" : 1004]
    ]
    
    static let notifArr = ["assignedJbK".localizableString(loc: Constant.lang),
                           "cancelJbK".localizableString(loc: Constant.lang),
                           "jobReqK".localizableString(loc: Constant.lang)
    ]
    
    
    
    static let pickerArr = ["30","60","90","120","150","180","210","240" ,"270","300"]
    
    
    static let pickerArrT = ["15","30","45","60","75","90","105","120" ,"135","150"]
    static let waitingTimeArr = ["0","5","10","15","20","25","30","35","40" ,"45","50","55","60","65","70","75","80","85","90","95","100","105","110","115","120"]

    
    
    static var jbIntrDeArr = [ "dateK".localizableString(loc: Constant.lang),
                               "modeK".localizableString(loc: Constant.lang),
                               "addressKey".localizableString(loc: Constant.lang),
                               "durationK".localizableString(loc: Constant.lang),
                               "callDurationAftrComptlngJbKey".localizableString(loc: Constant.lang),
                               "organisK".localizableString(loc: Constant.lang),
                               "langK".localizableString(loc: Constant.lang),
                               "categK".localizableString(loc: Constant.lang),
                               "contPerK".localizableString(loc: Constant.lang),
                               "emailK".localizableString(loc: Constant.lang),
                               "swornIkey".localizableString(loc: Constant.lang),
                               "dscK".localizableString(loc: Constant.lang),
                               "jbNumK".localizableString(loc: Constant.lang),
                               "postK".localizableString(loc: Constant.lang),
                               "acceptedByKey".localizableString(loc: Constant.lang),
                               "finalBillKey".localizableString(loc: Constant.lang)
        
        
    ]
    
    static var jbTransDeArr = ["dateK".localizableString(loc: Constant.lang),
                               "addressKey".localizableString(loc: Constant.lang),
                               "organisK".localizableString(loc: Constant.lang),
                               "langK".localizableString(loc: Constant.lang),
                               "contPerK".localizableString(loc: Constant.lang),
                               "emailK".localizableString(loc: Constant.lang),
                               "pagesK".localizableString(loc: Constant.lang),
                               "wordsK".localizableString(loc: Constant.lang),
                               "needStmpK".localizableString(loc: Constant.lang),
                               "docK".localizableString(loc: Constant.lang),
                               "postK".localizableString(loc: Constant.lang),
                               "acceptedByKey".localizableString(loc: Constant.lang),
                               "finalBillKey".localizableString(loc: Constant.lang)
        
    ]
    
    
}
