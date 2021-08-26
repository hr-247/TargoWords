//
//  InsertDocModal.swift
//  TolkApp
//
//  Created by sanganan on 6/14/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
struct InsertDocModal : Decodable
{
  var  Success : Int?
  var  Message : String?
  var insertedDoc : docModal?
    
    
    init(
    Success : Int?,
   Message : String?,
    insertedDoc : docModal?
    
    ) {
        
        self.Success = Success
        self.Message = Message
        self.insertedDoc = insertedDoc
    }
    
}
    
struct   docModal : Decodable{
     var docType : Int?
      var  _id : String?
       var  docName: String?
    
    init(
    docType : Int?,
     _id : String?,
      docName: String?
    
    ) {
        self.docType = docType
        self._id = _id
        self.docName = docName
        
        
    }
}
