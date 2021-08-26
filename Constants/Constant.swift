//
//  Constant.swift
//  HowrahBridge
//
//  Created by Ankit  Jain on 19/12/19.
//  Copyright © 2019 Sanganan. All rights reserved.
//

import UIKit

class Constant: NSObject {
    
    static let appDel = UIApplication.shared.delegate as! AppDelegate
    
    
    
    //MARK:- S3 Bucket name
    static let bucketName = "tolk"
    static let Testing = 1
    
    //MARK: selected langauage
    static let lang = Constant.appDel.selectdLang
    
    //MARK: Navigation Title
    struct navTitles
    {
        static let homeVCT    = "homeKey".localizableString(loc: Constant.lang)
        static let regVCT     = "registerK".localizableString(loc: Constant.lang)
        static let postJVCT   = "postJobK".localizableString(loc: Constant.lang)
        static let otpVCT     = "otpK".localizableString(loc: Constant.lang)
        static let roleVCT    = "roleK".localizableString(loc: Constant.lang)
        static let verNoVCT   = "verifyNuK".localizableString(loc: Constant.lang)
        static let upDocVCT   = "uploadDocK".localizableString(loc: Constant.lang)
        static let notifVCT   = "notifyK".localizableString(loc: Constant.lang)
        static let profVCT    = "profileK".localizableString(loc: Constant.lang)
        static let addrVCT    = "addressKey".localizableString(loc: Constant.lang)
        static let jobDeVCT   = "jobDetK".localizableString(loc: Constant.lang)
        static let langVCT    = "langsK".localizableString(loc: Constant.lang)
        static let calVCT     = "calendarKey".localizableString(loc: Constant.lang)
        static let catVCT     = "categoryKey".localizableString(loc: Constant.lang)
        static let payVCT     = "paymentKey".localizableString(loc: Constant.lang)
        static let payHisVCT  = "payHistKey".localizableString(loc: Constant.lang)
        static let cardDetVCT = "cardListKey".localizableString(loc: Constant.lang)
        static let otherVCT   = "otherkey".localizableString(loc: Constant.lang)
        static let editJobVCT = "editJobKey".localizableString(loc: Constant.lang)
        static let calDurVCT  = "calDurationKey".localizableString(loc: Constant.lang)
        static let tnCVCT     = "tnCKey".localizableString(loc: Constant.lang)
        static let accountVCT = "accountKey".localizableString(loc: Constant.lang)
        static let signatureVCT = "signatureKey".localizableString(loc: Constant.lang)
        static let uploadedVCT = "uploadedDocK".localizableString(loc: Constant.lang)
        
    }
    
    
    
    //MARK:- VC Titles
    struct vcTitles
    {
        static let interp = "interK".localizableString(loc: Constant.lang)
        static let transl = "transK".localizableString(loc: Constant.lang)
        static let serPer = "personalK".localizableString(loc: Constant.lang)
        static let serVid = "vidCallK".localizableString(loc: Constant.lang)
        static let serTel = "telephnicK".localizableString(loc: Constant.lang)
        static let swoYes = "yesK".localizableString(loc: Constant.lang)
        static let swoNo  = "noK".localizableString(loc: Constant.lang)
        static let selectlang = "selectLangK".localizableString(loc: Constant.lang)
        static let selctFrmLng = "slctFrmLngK".localizableString(loc: Constant.lang)
        static let selcttoLng = "slctToLngK".localizableString(loc: Constant.lang)
        static let pckCntry = "pckCntryK".localizableString(loc: Constant.lang)
        static let IntrJobKey = "createIntrJobKey".localizableString(loc: Constant.lang)
        static let transJobKey = "createtransJobKey".localizableString(loc: Constant.lang)
        
        
    }
    //MARK:- Placeholder Text
    struct Placeholder{
        static let nameTxt     = "nameKey".localizableString(loc: Constant.lang)
        static let phoneTxt    = "phoneKey".localizableString(loc: Constant.lang)
        static let emailTxt    = "emailKey".localizableString(loc: Constant.lang)
        static let passwordTxt = "passwordKey".localizableString(loc: Constant.lang)
        static let swiftNoTxt     = "swiftNoKey".localizableString(loc: Constant.lang)
        static let taxIDTxt    = "taxIDKey".localizableString(loc: Constant.lang)
        static let accountHolderTxt    = "accountHolderKey".localizableString(loc: Constant.lang)
        static let bnkAccountTxt = "bnkAccountKey".localizableString(loc: Constant.lang)
        static let saveTxt = "saveKey".localizableString(loc: Constant.lang)
        
    }
    
    //MARK:- Common Text
    struct Common{
        static let minsTxt     = "minsKey".localizableString(loc: Constant.lang)
        static let dateTimeTxt     = "dateTimeK".localizableString(loc: Constant.lang)
        static let cancelTxt     = "CancelKey".localizableString(loc: Constant.lang)
        static let doneTxt     = "DoneKey".localizableString(loc: Constant.lang)
        static let documentTxt     = "documentKey".localizableString(loc: Constant.lang)
        static let hoursTxt     = "hoursKey".localizableString(loc: Constant.lang)
        static let minutesTxt     = "mintesKey".localizableString(loc: Constant.lang)
        static let hourTxt     = "hourKey".localizableString(loc: Constant.lang)
        static let minuteTxt     = "minteKey".localizableString(loc: Constant.lang)
        
    }
    
    
    
    
    
    
    
    //MARK:- UserDefault data
    struct userData
    {
        static let name:String                 = "name"
        static let email:String                = "email"
        static let id:String                   = "id"
        static let phone : String              = "phone"
        static let addr : String               = "address"
        static let userImage : String          = "userImage"
        static let latitude : String           = "latitude"
        static let longitude : String          = "longitude"
        static let userType : String?          = "userType"
        static let paymentProfileId : String   = "paymentProfileId"
        static let creditCardVal : String      = "creditCardVal"
    }
    
    //MARK:- Messages to Display
    struct Msg{
        static let offlineMsg    = "NoInternetKey".localizableString(loc: Constant.lang)
        static let errorMsg      = "SomeWrongKey".localizableString(loc: Constant.lang)
        static let allFldsManMsg = "allFieldsManK".localizableString(loc: Constant.lang)
        static let invalNmeMsg   = "invalidNK".localizableString(loc: Constant.lang)
        static let invalEmlMsg   = "invalidEK".localizableString(loc: Constant.lang)
        static let phNoBlnkMsg   = "phNoBlnkK".localizableString(loc: Constant.lang)
        static let phTnDigMsg    = "phTenDigiK".localizableString(loc: Constant.lang)
        static let langErr       = "selectLangErrKey".localizableString(loc: Constant.lang)
        static let docErrMsg     = "docErrKey".localizableString(loc: Constant.lang)
        static let urlCpyMsg     = "urlCpyKey".localizableString(loc: Constant.lang)
        static let bnkAddedMsg   = "bankAccountAddedKey".localizableString(loc: Constant.lang)
        static let crdFrstMsg    = "credCrdFrstKey".localizableString(loc: Constant.lang)
        static let speDurMsg    = "specifyDurationKey".localizableString(loc: Constant.lang)
        static let noWrdsPgsMsg  = "ntrNoWrdsPgsKey".localizableString(loc: Constant.lang)
        static let pgsWrdsGrterMsg  = "pgsWrds>0Key".localizableString(loc: Constant.lang)
        static let teleNoNineMsg    = "teleNo9Key".localizableString(loc: Constant.lang)
        static let notLocationMsg  = "notLocationKey".localizableString(loc: Constant.lang)
        
    }
    
    //MARK:- APIs
    struct APIs {
        static let baseURL = "https://tolkappdev.herokuapp.com"
        
        //Class api url
        static let getLanguages = baseURL + "/getLanguages"
        static let addcreditcard = baseURL + "/addcreditcard"
        static let getpaymentprofiledetails = baseURL + "/getpaymentprofiledetails"
        static let getmypayments = baseURL + "/getmypayments"
        static let geTIpayments = baseURL + "/getTIsPaymentHistory"
        static let removecard = baseURL + "/removecard"
        static let updatejob = baseURL + "/updatejob"
        static let updateAccountDetails = baseURL + "/updateAccountDetails"
        static let getAccountDetails = baseURL + "/getAccountDetails"
        static let savejobduration = baseURL + "/savejobduration"
        static let uploadtranslateddoc = baseURL + "/uploadtranslateddoc"
        static let jobacceptedby = baseURL + "/jobacceptedby"
        static let urgentJobAcceptedby = baseURL + "/urgentJobAcceptedby"
        static let setdefaultpaymentsource = baseURL + "/setdefaultpaymentsource"
        
        
        
        
        
    }
    
    //MARK:- STORYBOARDS
    public struct Storyboards
    {
        static let home = UIStoryboard(name: "Main", bundle: nil)
    }
    public enum Controllers {
        case home
        case register
        case postJob
        case otp
        case role
        case verNo
        case upDoc
        case notif
        case profile
        case addr
        case jobD
        case selLang
        case calendar
        case approval
        case docRej
        case category
        case payment
        case paymentHistory
        case cardDetails
        case other
        case calculate
        case tnC
        case account
        case signature
        case translatorDoc
        
        func get()->UIViewController{
            switch self {
                
            case .home:
                return Storyboards.home.instantiateViewController(withIdentifier: "HomeViewController")
            case .register:
                return Storyboards.home.instantiateViewController(withIdentifier: "RegisterViewController")
            case .postJob:
                return Storyboards.home.instantiateViewController(withIdentifier: "PostJobViewController")
            case .otp:
                return Storyboards.home.instantiateViewController(withIdentifier: "OTPViewController")
            case .role:
                return Storyboards.home.instantiateViewController(withIdentifier: "RoleViewController")
            case .verNo:
                return Storyboards.home.instantiateViewController(withIdentifier: "VerifyNumViewController")
            case .upDoc:
                return Storyboards.home.instantiateViewController(withIdentifier: "UploadDocViewController")
            case .notif:
                return Storyboards.home.instantiateViewController(withIdentifier: "NotificationViewController")
            case .profile:
                return Storyboards.home.instantiateViewController(withIdentifier: "ProfileViewController")
            case .addr:
                return Storyboards.home.instantiateViewController(withIdentifier: "AddressViewController")
            case .jobD:
                return Storyboards.home.instantiateViewController(withIdentifier: "JobDetailViewController")
            case .selLang:
                return Storyboards.home.instantiateViewController(withIdentifier: "SelectLangViewController")
            case .calendar:
                return Storyboards.home.instantiateViewController(withIdentifier: "CalendarViewController")
            case .approval:
                return Storyboards.home.instantiateViewController(withIdentifier: "ApprovalPViewController")
            case .docRej:
                return Storyboards.home.instantiateViewController(withIdentifier: "DocRejectViewController")
            case .category:
                return Storyboards.home.instantiateViewController(withIdentifier: "CategoryViewController")
            case .payment:
                return Storyboards.home.instantiateViewController(withIdentifier: "PaymentViewController")
            case .paymentHistory:
                return Storyboards.home.instantiateViewController(withIdentifier: "PaymentHistoryViewController")
            case .cardDetails:
                return Storyboards.home.instantiateViewController(withIdentifier: "CardDetailsViewController")
            case .other:
                return Storyboards.home.instantiateViewController(withIdentifier: "OtherViewController")
            case .calculate:
                return Storyboards.home.instantiateViewController(withIdentifier: "CalculateViewController")
            case .tnC:
                return Storyboards.home.instantiateViewController(withIdentifier: "TermsViewController")
            case .account:
                return Storyboards.home.instantiateViewController(withIdentifier: "AccountDetailController")
            case .signature:
                return Storyboards.home.instantiateViewController(withIdentifier: "SignatureViewController")
            case .translatorDoc:
                return Storyboards.home.instantiateViewController(withIdentifier: "TranslatorDocViewController")
            }
        }
    }
    
    static func getMode(mode : Int) ->String{
        switch mode {
            
        case 5000:
            return "Personal Visit"
            
        case 5001:
            return "Video Call"
            
        case 5002:
            return "Telephonic"
            
        default:
            return "Personal Visit"
            
        }
    }
    
    static func getJobStatus(status : Int) ->String{
        switch status {
            
        case 4000:
            return "Accepted"
            
        case 4001:
            return "Pending"
            
        case 4002:
            return "Rejected"
            
        case 4003:
            return "Cancelled"
        case 4004:
            return "Completed"
        default:
            return "Personal Visit"
            
        }
    }
    
    
}

