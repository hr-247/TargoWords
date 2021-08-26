//
//  UpdateProfileModal.swift
//  TolkApp
//
//  Created by saurav sinha on 20/06/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

struct UpdateProfileModal : Codable {
    let success : Int?
    let message : String?
   // let result : Result?
    
    enum CodingKeys: String, CodingKey {
        
        case success = "Success"
        case message = "Message"
  //      case result = "result"
    }
    
}

//struct Result : Codable {
//    let n : Int?
//    let nModified : Int?
//    let opTime : OpTime?
//    let electionId : String?
//    let ok : Int?
//    let $clusterTime : $clusterTime?
//    let operationTime : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case n = "n"
//        case nModified = "nModified"
//        case opTime = "opTime"
//        case electionId = "electionId"
//        case ok = "ok"
//        case $clusterTime = "$clusterTime"
//        case operationTime = "operationTime"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        n = try values.decodeIfPresent(Int.self, forKey: .n)
//        nModified = try values.decodeIfPresent(Int.self, forKey: .nModified)
//        opTime = try values.decodeIfPresent(OpTime.self, forKey: .opTime)
//        electionId = try values.decodeIfPresent(String.self, forKey: .electionId)
//        ok = try values.decodeIfPresent(Int.self, forKey: .ok)
//        $clusterTime = try values.decodeIfPresent($clusterTime.self, forKey: .$clusterTime)
//        operationTime = try values.decodeIfPresent(String.self, forKey: .operationTime)
//    }
//
//}
//
//struct OpTime : Codable {
//    let ts : String?
//    let t : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case ts = "ts"
//        case t = "t"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        ts = try values.decodeIfPresent(String.self, forKey: .ts)
//        t = try values.decodeIfPresent(Int.self, forKey: .t)
//    }
//
//}
//
//struct $clusterTime : Codable {
//    let clusterTime : String?
//    let signature : Signature?
//
//    enum CodingKeys: String, CodingKey {
//
//        case clusterTime = "clusterTime"
//        case signature = "signature"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        clusterTime = try values.decodeIfPresent(String.self, forKey: .clusterTime)
//        signature = try values.decodeIfPresent(Signature.self, forKey: .signature)
//    }
//
//}
//
//struct Signature : Codable {
//    let hash : String?
//    let keyIdId : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case hash = "hash"
//        case keyId = "keyId"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        hash = try values.decodeIfPresent(String.self, forKey: .hash)
//        keyId = try values.decodeIfPresent(String.self, forKey: .keyId)
//    }
//
//}
