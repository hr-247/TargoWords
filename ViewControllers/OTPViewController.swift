//
//  OTPViewController.swift
//  TolkApp
//
//  Created by sanganan on 5/22/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
import FirebaseAuth

class OTPViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var entrOtpTxtField: UITextField!
    @IBOutlet weak var countDwnLbl: UILabel!
    @IBOutlet weak var resendOtpBtn: UIButton!
    @IBOutlet weak var didnotGtCode: UILabel!
    
    
    
    var verificationID : String = ""
    //MARK:- Variables
    var countDown = 90
    var timer:Timer?
    var phoneNumber : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.otpVCT, controller: Constant.Controllers.otp)
        
        didnotGtCode.text = "notGetCodeKey".localizableString(loc: Constant.lang)
        resendOtpBtn.setTitle("resndKey".localizableString(loc: Constant.lang), for: .normal)
        
        getOTP()
        
        if #available(iOS 12.0, *) {
            self.entrOtpTxtField.textContentType = .oneTimeCode
        } else {
            // Fallback on earlier versions
        }
        entrOtpTxtField.keyboardType = .numberPad
        self.entrOtpTxtField.setUnderLine()
        self.entrOtpTxtField.placeholder = "codeSntToKey".localizableString(loc: Constant.lang) + phoneNumber
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.resendOtpBtn.isEnabled = false
        self.resendOtpBtn.alpha = 0.4
    }
    
    func getOTP()
    {
        
        Auth.auth().languageCode = Constant.lang
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if  error != nil {
                AppUtils.showToast(message: Constant.Msg.errorMsg)
                return
            }
            self.verificationID = verificationID ?? ""
         
            self.startTimer()
        }
    }
    
    //MARK:- Start OTP Timer
    func startTimer()
    {
        //verify enable
        // resend disable
        countDown = 90
        
        self.resendOtpBtn.isEnabled = false
        self.resendOtpBtn.alpha = 0.4
        self.countDwnLbl.text = "\("resendIn".localizableString(loc: Constant.lang))01:30"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
    }
    
    //MARK:- Outlet Actions
    
    @IBAction func resendOtpTappd(_ sender: Any) {
        
        self.view.endEditing(true)
        self.stopTimer()
        getOTP()
          
        //        self.startTimer()
        
    }
    
    @IBAction func nxtBtn(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if self.entrOtpTxtField.text?.trimWhiteSpaces().count == 0
        {
            AppUtils.showToast(message: "enterOTPKey".localizableString(loc: Constant.lang))
            return
        }
        else {
            Utils.startLoading(self.view)
            
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID,
                verificationCode: self.entrOtpTxtField.text!)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                
                if error != nil
                {
                    Utils.stopLoading()
                    AppUtils.showToast(message: "notMatchOTPKey".localizableString(loc: Constant.lang))
                    return
                }
                self.checkNumberApi()
                
                
                // User is signed in
                // ...
            }
            
        }
        
        
    }
    
    //MARK:- when Timer will Stop
    override func viewWillDisappear(_ animated: Bool) {
        
        self.stopTimer()
        
    }
    
    //MARK:- Update OTP Timer
    @objc func updateCountDown() {
        if(countDown > 0) {
            countDwnLbl.text = self.timeFormatted(countDown)
            countDown = countDown - 1
            // timeFormatted(countDown)
        } else {
            
            self.stopTimer()
            self.removeCountDownLable()
            
        }
    }
    
    //MARK:- OTP Timer Format
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "\("resendIn".localizableString(loc: Constant.lang))%02d:%02d", minutes, seconds)
    }
    
    //MARK:- Remove OTP Label
    private func removeCountDownLable() {
        // resend enable
        // verify disable
        self.resendOtpBtn.isEnabled = true
        self.resendOtpBtn.alpha = 1.0
        
        countDown = 0
        countDwnLbl.text = ""
        
    }
    
    //MARK:- Stop OTP Timer
    func stopTimer()
    {
        DispatchQueue.main.async {
            self.timer?.invalidate()
            self.timer = nil
        }
        
    }
    
    //MARK:- TextField Check
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        if textField == self.entrOtpTxtField {
            
            let maxLength = 6
            let currentString:NSString = textField.text! as NSString
            let newString:NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            if allowedCharacters.isSuperset(of: characterSet) == false
            {
                
                return false
            }
            // code for paste and limiting them
            if (newString.length > 6){
                let mySubstring = String(newString).prefix(6)
                textField.text = String(mySubstring)
            }
            // end
            return newString.length <= maxLength
            
        }
        
        return true
    }
    
}

extension OTPViewController
{
    //Check Number Post Api
    func checkNumberApi()
    {
        
        let url:String = "\(Constant.APIs.baseURL)/checkAlreadyRegistered"
        let request:[String:Any] = ["mobileNo": self.phoneNumber]
        
        Service.sharedInstance.postRequest(Url:url,modalName: CheckNumberModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        
                        let userId = response?.userDetail?._id    // For client-side use only!
                        AppUtils.setStringForKey(key: Constant.userData.id, val: userId!)
                         if let em = response?.userDetail?.email
                         {
                        AppUtils.setStringForKey(key: Constant.userData.email, val: em)
                        }
                        
                        let nme = response?.userDetail?.name
                        AppUtils.setStringForKey(key: Constant.userData.name, val: nme!)
                        let phone = response?.userDetail?.phone
                        AppUtils.setStringForKey(key: Constant.userData.phone, val: phone!)
                        let uType = response?.userDetail?.userType
                        AppUtils.setStringForKey(key: Constant.userData.userType!, val: String(describing: uType!))
                        
                        if let profileId = response?.userDetail?.paymentProfileId
                                               {
                            AppUtils.setStringForKey(key: Constant.userData.paymentProfileId, val: profileId)

                                               }
                        
                        
                        Constant.appDel.userId = userId!
                        
                        Constant.appDel.profileApi(uId: Constant.appDel.userId)
                        
                        var userStatus = 2003
                        if let userSt = response?.userDetail?.userStatus
                        {
                            userStatus = userSt
                        }
                        
                        
                        AppUtils.AppDelegate().registerForAPNs(application: UIApplication.shared)
                        
                        if uType == 1000 || uType == 1002 || uType == 1003
                        {
                            if userStatus == 2000 || userStatus == 2003
                            {
                                let vc = Constant.Controllers.home.get() as! HomeViewController
                                self.navigationController?.pushViewController(vc, animated: true)
                                
                            }else if userStatus == 2002
                            {
                                
                                let vc = Constant.Controllers.approval.get() as! ApprovalPViewController
                                
                                self.navigationController?.pushViewController(vc, animated: true)                                                   }
                            else{
                                let vc = Constant.Controllers.docRej.get() as! DocRejectViewController
                                self.navigationController?.pushViewController(vc, animated: true)                                                   }
                        }else
                        {
                            let vc = Constant.Controllers.home.get() as! HomeViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }
            
                    }else{
                        
                        let vc = Constant.Controllers.tnC.get() as! TermsViewController
                        
                     vc.phoneNmbr = self.phoneNumber
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                }
            }}
        
    }
}

