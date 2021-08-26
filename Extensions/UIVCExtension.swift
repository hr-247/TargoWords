//
//  UIVCExtension.swift
//  SPP
//
//  Created by sanganan on 1/9/20.
//  Copyright © 2020 Sanganan. All rights reserved.

import UIKit
import SafariServices
import BSImagePicker
import Photos
import FirebaseAuth
//import MobileCoreServices



extension UIViewController : UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    static   var imagePicker = UIImagePickerController()
    
    
    func commonNavigationBar(title:String , controller:Constant.Controllers)
    {
        self.title = title
        let img = UIImage(named: "topbar")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
      //  navigationController?.navigationBar.barTintColor = UIColor.navBarC
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.isHidden = false
        switch (controller){
        case .home:
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "profile1"), for: .normal)
            button.addTarget(self, action: #selector(profActn), for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 29).isActive = true
            button.widthAnchor.constraint(equalToConstant: 29).isActive = true
            let barButtonItem = UIBarButtonItem(customView: button)
            self.navigationItem.leftBarButtonItem = barButtonItem
            
            let button2 = UIButton(type: .custom)
            button2.setImage(UIImage(named: "calander"), for: .normal)
            button2.addTarget(self, action: #selector(calActn), for: .touchUpInside)
            button2.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button2.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            
            let button3 = UIButton(type: .custom)
            button3.setImage(UIImage(named: "bell"), for: .normal)
            button3.addTarget(self, action: #selector(notifAtn), for: .touchUpInside)
            button3.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button3.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem3 = UIBarButtonItem(customView: button3)
            
            self.navigationItem.rightBarButtonItems = [barButtonItem3,barButtonItem2]
            break
            
        case .verNo,.approval:
            break
            
        case .register,.postJob,.otp,.role,.upDoc,.notif,.addr,.selLang,.calendar,.category,.payment,.paymentHistory,.cardDetails,.other,.calculate,.tnC,.account, .jobD,.signature, .translatorDoc:
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "arrowbk"), for: .normal)
            button.addTarget(self, action: #selector(backBtn), for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.widthAnchor.constraint(equalToConstant: 15).isActive = true
            let barButtonItem = UIBarButtonItem(customView: button)
            self.navigationItem.leftBarButtonItem = barButtonItem
            break
            
//        case .jobD:
//            let button = UIButton(type: .custom)
//                       button.setImage(UIImage(named: "arrowbk"), for: .normal)
//                       button.addTarget(self, action: #selector(backBtn), for: .touchUpInside)
//                       button.heightAnchor.constraint(equalToConstant: 25).isActive = true
//                       button.widthAnchor.constraint(equalToConstant: 15).isActive = true
//                       let barButtonItem = UIBarButtonItem(customView: button)
//                       self.navigationItem.leftBarButtonItem = barButtonItem
//
//            let button2 = UIButton(type: .custom)
//            button2.setTitle("Add", for: .normal)
//            button2.addTarget(self, action: #selector(jobEditActn), for: .touchUpInside)
//          //  button2.heightAnchor.constraint(equalToConstant: 25).isActive = true
//         //   button2.widthAnchor.constraint(equalToConstant: 25).isActive = true
//            let barButtonItem2 = UIBarButtonItem(customView: button2)
//            self.navigationItem.rightBarButtonItem = barButtonItem2
//                       break
            
        case .docRej:
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "arrowbk"), for: .normal)
            button.addTarget(self, action: #selector(docbckBtn), for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.widthAnchor.constraint(equalToConstant: 15).isActive = true
            let barButtonItem = UIBarButtonItem(customView: button)
            self.navigationItem.leftBarButtonItem = barButtonItem
            break
            
        case .profile:
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "arrowbk"), for: .normal)
            button.addTarget(self, action: #selector(backBtn), for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.widthAnchor.constraint(equalToConstant: 15).isActive = true
            let barButtonItem = UIBarButtonItem(customView: button)
            self.navigationItem.leftBarButtonItem = barButtonItem
            
            let button2 = UIButton(type: .custom)
            button2.setImage(UIImage(named: "card"), for: .normal)
            button2.addTarget(self, action: #selector(cardActn), for: .touchUpInside)
            button2.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button2.widthAnchor.constraint(equalToConstant: 25).isActive = true
            let barButtonItem2 = UIBarButtonItem(customView: button2)
            self.navigationItem.rightBarButtonItem = barButtonItem2
            break
        }
    }
    @objc func backBtn()
    {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func docbckBtn()
    {
        let vc =  Constant.Controllers.upDoc.get() as! UploadDocViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func notifAtn()
    {
        let vc = Constant.Controllers.notif.get() as! NotificationViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func profActn()
    {
        let vc = Constant.Controllers.profile.get() as! ProfileViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func calActn()
    {
        let vc = Constant.Controllers.calendar.get() as! CalendarViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func cardActn()
    {
        let vc = Constant.Controllers.other.get() as! OtherViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func jobEditActn()
    {
//        let task = "Edit"
//     let vc = Constant.Controllers.postJob.get() as! PostJobViewController
//        vc.whPage = task
//        navigationController?.pushViewController(vc, animated: true)
    }
 
    @objc func getcat(_ sender: UIButton)
    {
        let vc = Constant.Controllers.category.get() as! CategoryViewController
        vc.delegate = self  as? sendCatProtocol
        let nav = UINavigationController(rootViewController: vc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    @objc func upDocActn(sender: UIButton)
    {
        
        let alert:UIAlertController=UIAlertController(title: "choseImgKey".localizableString(loc: Constant.lang), message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "choseExstngImgKey".localizableString(loc: Constant.lang), style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.checkLibraryCalling()
        }
        let gallaryAction = UIAlertAction(title: "newPhotoKey".localizableString(loc: Constant.lang), style: UIAlertAction.Style.default )             {
            UIAlertAction in
            self.checkCamera()
        }
        let cancelAction = UIAlertAction(title: "CancelKey".localizableString(loc: Constant.lang), style: UIAlertAction.Style.cancel)       {
            UIAlertAction in
        }
        
        // Add the actions
        UIViewController.imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        //self.checkLibraryCalling()
   
    }
    
    
    @objc func alertDialog()
    {
        let alertController = UIAlertController(title: "SignOutKey".localizableString(loc: Constant.lang), message: "signOutConfirmKey".localizableString(loc: Constant.lang), preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OKKey".localizableString(loc: Constant.lang), style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.logOutA()
        }
        
        let cancelAction = UIAlertAction(title: "CancelKey".localizableString(loc: Constant.lang), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancelled")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func logOutA()
    {
        DispatchQueue.main.async{
            
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            self.logOutApi()
        }
        
    }
    
    var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- open site
    func openSite()
    {
        let url = "https://www.google.com"
        let safari = SFSafariViewController(url: URL(string: url)!)
        self.present(safari, animated: true, completion: nil)
        
    }
    //MARK:- Tap Gesture
    public func tapGesture(forVc place: UIViewController, forView view:UIView, section: Int) {
        let tap = UITapGestureRecognizer(target: place, action: #selector(tapGestureActn))
      
        tap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tap)
    }
    @objc func tapGestureActn(sender: UITapGestureRecognizer) {
        
    }
   
    //MARK:- HideKeybord onclick Return
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Touches Began Func
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    // MARK:- Email validation
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "^[a-zA-Z][A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,4}$"
      //  let trimmedString = testStr.trimmingCharacters(in: .whitespaces)
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
        
    }
    
    // MARK:- username Validation
    func isValidUsrName(testStr:String) -> Bool {
        
        guard testStr.count > 2, testStr.count < 18 else { return false }

        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
    }
    
    //MARK:- Mobile Number Validation
    func isValidMblNum(testStr:String) -> Bool {
        
        print("validate MblNum: \(testStr)")
        let mblNumRegEx = "^\\d{10}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", mblNumRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
        
    }
    
    //MARK:- UIIMAGEPICKER

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil{
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    // MARK:checkinPhotosAcess
    func checkLibraryCalling()
    {
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized) {
            print("Access has been granted.")
            UIViewController.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(UIViewController.imagePicker, animated: true, completion: nil)
        }
            
        else if (status == PHAuthorizationStatus.denied) {
            print("Access has been denied..")
            let alert = UIAlertController(
                title: "importntKey".localizableString(loc: Constant.lang),
                message: "libryAccessReqKey".localizableString(loc: Constant.lang),
                preferredStyle: UIAlertController.Style.alert
            )
            alert.addAction(UIAlertAction(title: "CancelKey".localizableString(loc: Constant.lang), style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "allwLibryKey".localizableString(loc: Constant.lang), style: .cancel, handler: { (alert) -> Void in
                UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
            }))
            present(alert, animated: true, completion: nil)
        }
            
        else if (status == PHAuthorizationStatus.notDetermined) {
            
            print("Access has been detemined.")
            UIViewController.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(UIViewController.imagePicker, animated: true, completion: nil)
            
        }
            
        else if (status == PHAuthorizationStatus.restricted) {
            // Restricted access - normally won't happen.
            let alert = UIAlertController(
                title: "importntKey".localizableString(loc: Constant.lang),
                message: "libryAccessReqKey".localizableString(loc: Constant.lang),
                preferredStyle: UIAlertController.Style.alert
            )
            alert.addAction(UIAlertAction(title: "CancelKey".localizableString(loc: Constant.lang), style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "allwLibryKey".localizableString(loc: Constant.lang), style: .cancel, handler: { (alert) -> Void in
                UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    // MARK: -  checkingCameraAccess
    func callCamera(){
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerController.SourceType.camera
        
        self.present(myPickerController, animated: true, completion: nil)
        NSLog("Camera");
    }
    func checkCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized: callCamera() // Do your stuff here i.e. callCameraMethod()
        case .denied: alertToEncourageCameraAccessInitially()
        //  case .notDetermined: alertToEncourageCameraAccessInitially()
        default: callCamera()
        }
    }
    
    func alertToEncourageCameraAccessInitially() {
        let alert = UIAlertController(
            title: "importntKey".localizableString(loc: Constant.lang),
            message: "cameraAccessReqKey".localizableString(loc: Constant.lang),
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "CancelKey".localizableString(loc: Constant.lang), style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "allwCameraKey".localizableString(loc: Constant.lang), style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:-Logout API
    func logOutApi()
    {
        
        let url:String = "\(Constant.APIs.baseURL)/logoutuser"
        let uId = AppUtils.getStringForKey(key: Constant.userData.id)
        
        guard let fcmTokn = AppUtils.getStringForKey(key: "FcmToken") else {
            self.clearData()
            return
        }
        Utils.startLoading(self.view)
        
        var request : [String : Any] = [String : Any]()
        request = ["userId" : uId!, "fcmId" : fcmTokn]
        
        Service.sharedInstance.postRequest(Url:url,modalName: LogoutModal.self , parameter: request as [String:Any]) { (response, error) in
            Utils.stopLoading()
            self.clearData()
        }
    }
    
    func clearData()
    {
        AppUtils.removeDataFrom(key: Constant.userData.id)
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        let vc = Constant.Controllers.verNo.get() as! VerifyNumViewController
        self.navigationController?.pushViewController(vc, animated: true)
        AppUtils.showToast(message: "SignedOutSucKey".localizableString(loc: Constant.lang))
    }
    
    
}




