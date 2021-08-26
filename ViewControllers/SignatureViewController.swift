//
//  SignatureViewController.swift
//  TolkApp
//
//  Created by sanganan on 7/22/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
import YPDrawSignatureView

class SignatureViewController: UIViewController {
    
    
    //variables
    var startTime = ""
    var endTime = ""
    var waitTime = ""
    var duration = ""
    
    var jobId = ""
    var durationInt = 0
    var waiting = 0
    var jobCreaterId = ""
    var startTimeStamp = 0
    var endTimeStamp = 0
    var signatureImg = ""
    
    
    //Outlets
    @IBOutlet weak var startTimeLbl: UILabel!
    @IBOutlet weak var endTimeLbl: UILabel!
    @IBOutlet weak var waitTimeLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var signatureView: YPDrawSignatureView!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var nxtBtn: UIButton!
    @IBOutlet weak var strtTymHeadng: UILabel!
    @IBOutlet weak var endTymHeading: UILabel!
    @IBOutlet weak var waitingHeading: UILabel!
    @IBOutlet weak var duratnHeading: UILabel!
    @IBOutlet weak var SignHeading: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.signatureVCT, controller: Constant.Controllers.signature)
        
        strtTymHeadng.text = "strtTmeKey".localizableString(loc: Constant.lang)
        endTymHeading.text = "endTmeKey".localizableString(loc: Constant.lang)
        waitingHeading.text = "waitTmeKey".localizableString(loc: Constant.lang)
        duratnHeading.text = "durationK".localizableString(loc: Constant.lang)
        SignHeading.text = "toSubmitKey".localizableString(loc: Constant.lang)
        clearBtn.setTitle("clearKey".localizableString(loc: Constant.lang), for: .normal)
        
        
        
        
        self.startTimeLbl.text = startTime
        self.endTimeLbl.text = endTime
        self.durationLbl.text = duration
        self.waitTimeLbl.text = waitTime
        // signatureView.delegate = self
    }
    
    @IBAction func clearActn(_ sender: UIButton) {
        self.signatureView.clear()
    }
    
    @IBAction func nextBtnActn(_ sender: UIButton) {
        if let signatureImage = self.signatureView.getSignature(scale: 10) {
            
            
            //UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
            
            
            //            self.signatureView.clear()
            //            self.navigationController?.popViewController(animated: true)
            
            
            uploadImageToAWS(signatureImage) { (urlStr, error) in
                       
                       if let url = urlStr
                       {
                           
                        self.signatureImg  = url
                       }
                self.savejobdurationApi()
            }
        }else
        {
            AppUtils.showToast(message: "sgnTSubmitKey".localizableString(loc: Constant.lang))
            
        }
    }
    
    //save job duration Post Api
    func savejobdurationApi()
    {
        Utils.startLoading(self.view)
        let request:[String:Any] = ["ti" : AppUtils.AppDelegate().userId,
                                    "jobCreater" : jobCreaterId,
                                    "job": jobId,
                                    "startTime": startTimeStamp,
                                    "endTime": endTimeStamp,
                                    "signature":self.signatureImg,
                                    "callDuration":  durationInt ,
                                    "waitingTime": waiting
        ]
        Service.sharedInstance.postRequest(Url:Constant.APIs.savejobduration,modalName: approvedDocModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        
                        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "PostJob"), object: nil)
                        
                        
                        for item in self.navigationController?.viewControllers ?? [UIViewController]()
                        {
                            if item is HomeViewController {
                                
                                self.navigationController?.popToViewController(item, animated: true)
                                break;
                            }
                        }
                        
                        AppUtils.showToast(message: "jbCmpltdKey".localizableString(loc: Constant.lang))
                        //     AppUtils.showToast(message: (response?.Message)!)
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                }
            }
        }
    }
    
    
    
    
    // MARK: - Delegate Methods
    
    func didStart() {
        print("Started Drawing")
    }
    
    func didFinish() {
        print("Finished Drawing")
    }
    
}
