//
//  JobDetailViewController.swift
//  TolkApp
//
//  Created by sanganan on 5/29/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit


class JobDetailViewController: UIViewController, TranslatorLinkDeleagate {
    
    //Outlets
    @IBOutlet weak var jobDeTV: UITableView!
    
    //Variables
    var jobsArr = jobDetailList()
    var jobId = ""
    var sLanguage = ""
    var dLanguage = ""
    var jobStatus : Int? = Int()
    var userType : String = ""
    var transDoc = [uploadDocModal]()
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.jobDeVCT, controller: Constant.Controllers.jobD)
        if let uType = AppUtils.getStringForKey(key: Constant.userData.userType!)
        {
            userType = uType
        }
        
        jobDeTV.register(UINib(nibName: "JobDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "JobDetailTableViewCell")
        //        jobDeTV.register(UINib(nibName: "TranslatedDocTableViewCell", bundle: nil), forCellReuseIdentifier: "TranslatedDocTableViewCell")
        jobDeTV.register(UINib(nibName: "JobDetailButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "JobDetailButtonsTableViewCell")
        jobDeTV.register(UINib(nibName: "TranslatorLinkCell", bundle: nil), forCellReuseIdentifier: "TranslatorLinkCell")

        
        
        jobDeTV.backgroundView = UIImageView(image: UIImage(named: "whitebg"))
        jobDeTV.delegate = self
        jobDeTV.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        JobDetail()
    }
    
    @objc func acceptJobctn()
    {
        jobAcceptApi()
        //     jobStatusApi(jobStatus: 4000)
        
    }
    @objc func rejectJobctn()
    {
        
        jobStatusApi(jobStatus: 4002)
    }
    @objc func cancelJobctn()
    {
        
        
        
        if jobsArr.jobStatus == 4000 && userType == "1004" {
  
        let alertController = UIAlertController(title: "Cancel Job", message: "You will get full refund if cancellation is made before 24 hours. of job time. No refund will be initiated if you cancel the job within 24 hours. of job start time. Are you sure you want to cancel this job?", preferredStyle: .alert)
               
               // Create the actions
               let okAction = UIAlertAction(title: "yesK".localizableString(loc: Constant.lang), style: UIAlertAction.Style.default) {
                   UIAlertAction in
                self.jobStatusApi(jobStatus: 4003)
               }
               
               let cancelAction = UIAlertAction(title: "noK".localizableString(loc: Constant.lang), style: UIAlertAction.Style.cancel) {
                   UIAlertAction in
                   NSLog("Cancelled")
               }
               
               alertController.addAction(okAction)
               alertController.addAction(cancelAction)
               self.present(alertController, animated: true, completion: nil)
        
        
        }else
        {
            self.jobStatusApi(jobStatus: 4003)
        }
       
        
        
    }
    
    //    @objc override func jobEditActn()
    //    {     //for edit Job
    //
    //                let vc = Constant.Controllers.postJob.get() as! PostJobViewController
    //                vc.whPage = true
    //                if jobsArr.jobType == 1000
    //                {
    //                    vc.whJob = 0
    //                }else{
    //                    vc.whJob = 1
    //                }
    //                vc.preFillData = jobsArr
    //                navigationController?.pushViewController(vc, animated: true)
    //
    //    }
    
    
    @objc func translatedDocActn()
    {
        
        let vc = Constant.Controllers.translatorDoc.get() as! TranslatorDocViewController
        
        vc.jbCreaterPagesNo = String(describing: jobsArr.noOfPages!)
        vc.jbCreaterWordsNo = String(describing: jobsArr.noOfWords!)
        if let doc = jobsArr.documents
        {
            vc.jbCreatertranslatedDoc = doc
        }
        
        if userType == "1002" || userType == "1003"
        {
            if let assignId = jobsArr.assignedTo?._id{
                vc.tiId = assignId
            }
            if let createdId = jobsArr.userCreatedBy._id{
                
                vc.jobCreaterId = createdId
            }
            if let jobId = jobsArr._id{
                
                vc.jobId = jobId
            }
           // vc.imagesArr = self.transDoc
            
//            var arr = [uploadDocuments]()
//            for item in self.transDoc
//            {
//
//                arr.append(uploadDocuments(documentTitle: "", documentUrl: item.documentUrl))
//            }
//
//            vc.imagesArr = arr;
            
        }else{
            vc.pagesNo = String(describing: jobsArr.finalNoOfPages!)
            vc.wordsNo = String(describing: jobsArr.finalNoOfWords!)
            vc.translatedDoc = self.transDoc
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func completeJobActn()
    {
        let vc =  Constant.Controllers.calculate.get() as! CalculateViewController
        
        if let jobId = jobsArr._id{
            
            vc.jobId = jobId
        }
        if let createdId = jobsArr.userCreatedBy._id{
            
            vc.jobCreaterId = createdId
        }
        if let strtDate = self.jobsArr.jobDate
        {
            vc.jobDate = strtDate
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension JobDetailViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            if userType == "1000" || userType == "1002" || userType == "1003"
            {
                if jobsArr.jobType == 1000
                {
                    return classConst.jbIntrDeArr.count - 2
                }else{
                    return classConst.jbTransDeArr.count - 2
                }
            }
            else
            {
                if jobsArr.jobType == 1000
                {
                    if jobsArr.jobStatus == 4004
                    {
                        return classConst.jbIntrDeArr.count
                    }
                    else if jobsArr.jobStatus == 4000
                    {
                        return classConst.jbIntrDeArr.count - 1}
                    else{
                        return classConst.jbIntrDeArr.count - 2
                    }
                }else{
                    if jobsArr.jobStatus == 4004
                    {
                        return classConst.jbTransDeArr.count
                    }
                    else if jobsArr.jobStatus == 4000
                    {
                        return classConst.jbTransDeArr.count - 1}
                    else{
                        return classConst.jbTransDeArr.count - 2
                    }
                    
                }
            }
        }
        else if section == 1
            {
                
                
                
                
                       if self.jobsArr.jobType == 1002
                       {
                        let userId = AppUtils.getStringForKey(key: Constant.userData.id)
                        if userId == self.jobsArr.userCreatedBy._id
                                          {
                                            
                                            return 1;
                                            
                        }else{
                            if jobsArr.jobStatus == 4000
                            {
                                 return 1;
                            }
                            
                        }
                          
            }
                          return 0
        }
        else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 88
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailTableViewCell", for: indexPath) as! JobDetailTableViewCell
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailTableViewCell", for: indexPath) as! JobDetailTableViewCell
            cell.headingLbl.isHidden = false
            cell.lineVw.isHidden = false
            cell.dscLbl.isHidden = false
            cell.translatorDocCV.isHidden = true
            cell.billBtn.isHidden = true
            cell.contentView.isHidden = false

            if jobsArr.jobType == 1000
            {
                cell.headingLbl.text = classConst.jbIntrDeArr[indexPath.row]
                
            }else{
                cell.headingLbl.text = classConst.jbTransDeArr[indexPath.row]
            }
            
            if jobsArr.jobType == 1000
            {
                if indexPath.row == 0
                {
                    if let date = self.jobsArr.jobDate
                    {
                        cell.dscLbl.text  = AppUtils.timestampToDate(timeStamp: Double(date))
                    }
                }
                else if indexPath.row == 1
                {
                    if let service =  self.jobsArr.jobServiceType
                    {
                        cell.dscLbl.text = Constant.getMode(mode: service)
                    }
                }
                else if indexPath.row == 2
                {
                    cell.dscLbl.text  = self.jobsArr.address
                }
                else if indexPath.row == 3
                {
                    if let dur = self.jobsArr.duration
                    {
                        cell.dscLbl.text = String(describing: dur/60) + " \(Constant.Common.minsTxt)"
                    }
                }
                else if indexPath.row == 4
                {
                    if let dur = self.jobsArr.finalCallDuration
                    {
                        if dur == 0
                        {
                            cell.contentView.isHidden = true
                            return cell;
                        }
                        
                        cell.dscLbl.text = String(describing: dur/60) + " \(Constant.Common.minsTxt)"
                    }
                }
                    
                else if indexPath.row == 5
                {
                    if let organ = self.jobsArr.organization
                    {
                        cell.dscLbl.text  = organ
                    }
                }
                else if indexPath.row == 6
                {
                    if  let sLang = self.jobsArr.sourceLanguage?.language
                    {
                        self.sLanguage = sLang
                    }else{
                        self.sLanguage = " "
                    }
                    if  let dLang = self.jobsArr.destinationLanguage?.language
                    {
                        self.dLanguage = dLang
                    }else{
                        self.dLanguage = " "
                    }
                    
                    cell.dscLbl.text  = self.sLanguage + "-" + self.dLanguage
                }
                else if indexPath.row == 7
                {
                    cell.dscLbl.text  = self.jobsArr.category?.name
                }
                else if indexPath.row == 8
                {
                    cell.dscLbl.text  = self.jobsArr.contactPerson
                }
                else if indexPath.row == 9
                {
                    cell.dscLbl.text = self.jobsArr.email
                }
                else if indexPath.row == 10
                {
                    let sworn = self.jobsArr.needSwormIntepretor
                    if sworn == true
                    {
                        cell.dscLbl.text = "yesK".localizableString(loc: Constant.lang)
                    }else{
                        cell.dscLbl.text = "noK".localizableString(loc: Constant.lang)
                    }
                }
                else if indexPath.row == 11
                {
                    cell.dscLbl.text = self.jobsArr.jobDescription
                }
                else if indexPath.row == 12
                {
                    if let no = self.jobsArr.jobNumber
                    {
                        cell.dscLbl.text = String(describing: no)
                    }
                }
                else if indexPath.row == 13
                {
                    if let date = self.jobsArr.createdTime
                    {
                        cell.dscLbl.text  = AppUtils.timestampToDate(timeStamp: Double(date))
                    }
                }
                else if indexPath.row == 14
                {
                    cell.dscLbl.text  = self.jobsArr.acceptedBy?.name
                }
                else if indexPath.row == 15
                {
                    cell.billBtn.isHidden = false
                    if let bill = self.jobsArr.finalBill
                    {
                        cell.billBtn.setTitle(bill, for: .normal)
                    }
                    cell.billBtn.addTarget(self, action: #selector(invoiceDwnload), for: .touchUpInside)
                }
                return cell
                
            }else{
                if indexPath.row == 0
                {
                    if let date = self.jobsArr.jobDate
                    {
                        cell.dscLbl.text  = AppUtils.timestampToDate(timeStamp: Double(date))
                    }
                    
                }
                else if indexPath.row == 1
                {
                    
                    cell.dscLbl.text = self.jobsArr.address
                    
                }
                else if indexPath.row == 2
                {
                    if let organ = self.jobsArr.organization
                    {
                        cell.dscLbl.text  = organ
                    }
                }
                else if indexPath.row == 3
                {
                    if  let sLang = self.jobsArr.sourceLanguage?.language
                    {
                        self.sLanguage = sLang
                    }else{
                        self.sLanguage = " "
                    }
                    
                    if  let dLang = self.jobsArr.destinationLanguage?.language
                    {
                        self.dLanguage = dLang
                    }else{
                        self.dLanguage = " "
                    }
                    
                    cell.dscLbl.text  = self.sLanguage + "-" + self.dLanguage
                    
                }
                else if indexPath.row == 4
                {
                    cell.dscLbl.text = self.jobsArr.contactPerson
                }
                else if indexPath.row == 5
                {
                    cell.dscLbl.text  = self.jobsArr.email
                    
                }
                else if indexPath.row == 6
                {
                    if let pages = self.jobsArr.noOfPages
                    {
                        cell.dscLbl.text  = String(describing: pages)
                    }
                }
                else if indexPath.row == 7
                {
                    if let words =  self.jobsArr.noOfWords
                    {
                        cell.dscLbl.text  = String(describing: words)
                    }
                }
                else if indexPath.row == 8
                {
                    let stmps = self.jobsArr.needStamps
                    if stmps == true
                    {
                        cell.dscLbl.text = "yesK".localizableString(loc: Constant.lang)
                    }else{
                        cell.dscLbl.text = "noK".localizableString(loc: Constant.lang)
                    }
                }
                else if indexPath.row == 9
                {
                    cell.translatorDocCV.isHidden = false
                    //   cell.cvheightCons.constant = 50
                    cell.dscLbl.isHidden = true
                    if let doc = self.jobsArr.documents
                    {
                        cell.docsArr = doc
                    }else{
                        cell.translatorDocCV.isHidden = true
                        
                    }
                    cell.reloadCollection()
                }
                else if indexPath.row == 10
                {
                    if let date = self.jobsArr.createdTime
                    {
                        cell.dscLbl.text  = AppUtils.timestampToDate(timeStamp: Double(date))
                    }
                    
                }
                else if indexPath.row == 11
                {
                    cell.dscLbl.text  = self.jobsArr.acceptedBy?.name
                }
                else if indexPath.row == 12
                {
                    cell.dscLbl.text  = self.jobsArr.finalBill
                }
                return cell
            }
            
        }
            //         else if indexPath.section == 1
            //            {
            //
            //                let cell = tableView.dequeueReusableCell(withIdentifier: "TranslatedDocTableViewCell", for: indexPath) as! TranslatedDocTableViewCell
            //                cell.translatedDocBtn.backgroundColor = UIColor.undrC
            //
            //                if indexPath.row == 0
            //                {
            //                if userType == "1004"
            //                {
            //                    cell.translatedDocBtn.setTitle("See translated documents", for: .normal)
            //                }
            //                cell.translatedDocBtn.addTarget(self, action: #selector(translatedDocActn), for: .touchUpInside)
            //                return cell
            //               }
            //        }
        else if indexPath.section == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JobDetailButtonsTableViewCell", for: indexPath) as! JobDetailButtonsTableViewCell
            cell.delegate = self as JobDetailDelegate
            cell.translatedDocBtn.isHidden = true
            cell.linkBtn.isHidden = true
            cell.shareBtn.isHidden  = true
            cell.copyBtn.isHidden = true
            cell.cancelledLbl.isHidden = true
            cell.accptBtn.isHidden  = true
            cell.rjctBtn.isHidden = true
            cell.cancelBtn.isHidden = true
            cell.rejectedLbl.isHidden = true
            cell.completedLbl.isHidden = true
            cell.codeLbl.isHidden = true
            cell.completeJob.isHidden = true
            cell.completeJob.addTarget(self, action: #selector(completeJobActn), for: .touchUpInside)
            
            if indexPath.row == 0
            {
                guard let jD = jobsArr.jobDate else {return UITableViewCell()}
                
                let jobDate = AppUtils.timestampToDate(timeStamp: Double(jD))
                let   dateTimeFormat = "d MMMM yyyy, hh:mm a"
                let currentDate = AppUtils.getParticularTimeFormat(format: dateTimeFormat, date: Date())
                let timeDiff = AppUtils.CompareDate(time1Str: currentDate, time2Str: jobDate)
                
                if self.jobStatus == 4000 && self.jobsArr.jobServiceType == 5001
                {
                    cell.linkBtn.isHidden = false
                    cell.linkBtn.setTitle("https://www.targo.world/\(self.jobId)/\(AppUtils.AppDelegate().userId)", for: .normal)
                    
                    cell.shareBtn.isHidden  = false
                    cell.copyBtn.isHidden = false
                    
                    // set link text here
                    let userId = AppUtils.getStringForKey(key: Constant.userData.id)
                    if userId == self.jobsArr.userCreatedBy._id
                    {
                        cell.codeLbl.isHidden = false
                        cell.codeLbl.layer.cornerRadius = 15
                        cell.codeLbl.layer.masksToBounds = true
                        if let code = self.jobsArr.pinCode
                        {
                            cell.codeLbl.text = "\("pinToStrtMeetngKey".localizableString(loc: Constant.lang)) \(code)"
                        }
                    }
                    
                }else
                {
                    
                    if self.userType == "1004"
                    {
                        
                        if self.jobStatus == 4003
                        {
                            cell.cancelledLbl.isHidden = false
                            cell.cancelledLbl.layer.cornerRadius = 15
                            cell.cancelledLbl.layer.masksToBounds = true
                        }
                            
                            
                        else{
                            cell.cancelledLbl.isHidden = true
                            cell.cancelBtn.isHidden = false
                            cell.cancelBtn.addTarget(self, action: #selector(cancelJobctn), for: .touchUpInside)
                        }
                    }
                        
                    else{
                        
                        if self.jobStatus == 4003
                        {
                            
                            cell.cancelledLbl.isHidden = false
                            cell.cancelledLbl.layer.cornerRadius = 15
                            cell.cancelledLbl.layer.masksToBounds = true
                        }
                            
                        else if self.jobStatus == 4000
                        {
                            
                            if self.transDoc.count != 0
                            {
                                cell.translatedDocBtn.isHidden = true
                                cell.cancelBtn.isHidden = true
                            }else{
                                cell.cancelBtn.isHidden = false
                                cell.cancelBtn.addTarget(self, action: #selector(cancelJobctn), for: .touchUpInside)
                                if jobsArr.jobType == 1000 && jobsArr.jobServiceType == 5000 && timeDiff <= 0
                                {
                                    cell.completeJob.isHidden = false
                                    cell.completeJob.addTarget(self, action: #selector(completeJobActn), for: .touchUpInside)
                                    
                                }else{
                                    cell.completeJob.isHidden = true
                                }
                            }
                        }
                        else if self.jobStatus == 4002
                        {
                            
                            cell.rejectedLbl.isHidden = false
                            cell.rejectedLbl.layer.cornerRadius = 15
                            cell.rejectedLbl.layer.masksToBounds = true
                        }
                        else if  self.jobStatus == 4004
                        {
                            cell.completedLbl.backgroundColor = UIColor.undrC
                            cell.completedLbl.isHidden = false
                            cell.completedLbl.layer.cornerRadius = 15
                            cell.completedLbl.layer.masksToBounds = true
                            cell.completeJob.isHidden = true
                        }
                            
                            
                        else{
                            if timeDiff <= 0
                            {
                                cell.accptBtn.isHidden = true
                                cell.rjctBtn.isHidden = true
                            }else{
                                
                                cell.accptBtn.isHidden  = false
                                cell.accptBtn.addTarget(self, action: #selector(acceptJobctn), for: .touchUpInside)
                                cell.rjctBtn.isHidden = false
                                cell.rjctBtn.addTarget(self, action: #selector(rejectJobctn), for: .touchUpInside)
                            }
                        }
                        
                    }
                    
                }
                
                
                if self.jobsArr.jobType == 1002
                {
                    if self.jobStatus == 4004
                    {
                        cell.cancelledLbl.isHidden = true
                        cell.cancelBtn.isHidden = true
                        cell.completedLbl.backgroundColor = UIColor.undrC
                        cell.completedLbl.isHidden = false
                        cell.completedLbl.layer.cornerRadius = 15
                        cell.completedLbl.layer.masksToBounds = true
                        
                        if userType == "1004"
                        {
                            cell.translatedDocBtn.backgroundColor = UIColor.undrC
                            
                            cell.translatedDocBtn.setTitle("seeTransDocKey".localizableString(loc: Constant.lang), for: .normal)
                            
                            cell.translatedDocBtn.isHidden = false
                            
                            cell.translatedDocBtn.addTarget(self, action: #selector(translatedDocActn), for: .touchUpInside)
                            
                        }
                    }else if self.jobStatus == 4000
                    {
                        
                        cell.cancelBtn.isHidden = false
                        
                        cell.cancelBtn.addTarget(self, action: #selector(cancelJobctn), for: .touchUpInside)
                        
                        if userType != "1004"
                        {
                            cell.translatedDocBtn.backgroundColor = UIColor.undrC
                            
                            cell.translatedDocBtn.setTitle("transUploadKey".localizableString(loc: Constant.lang), for: .normal)
                            
                            cell.translatedDocBtn.isHidden = false
                            
                            cell.translatedDocBtn.addTarget(self, action: #selector(translatedDocActn), for: .touchUpInside)
                            
                        }
                        
                    }
                }
                
                
                if self.jobStatus == 4004
                {
                    cell.cancelledLbl.isHidden = true
                    cell.cancelBtn.isHidden = true
                    cell.completedLbl.backgroundColor = UIColor.undrC
                    cell.completedLbl.isHidden = false
                    cell.completedLbl.layer.cornerRadius = 15
                    cell.completedLbl.layer.masksToBounds = true
                    
                }
                
                return cell
                
            }
            
        }else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TranslatorLinkCell", for: indexPath) as! TranslatorLinkCell
            
            cell.delegate = self
            
            cell.linkBtn.setTitle("https://targoworldreact.web.app/uploaddocument/\(self.jobId)/\(userType)", for: .normal)
            
            
            
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            if jobsArr.jobType == 1000
            {
                    
               
                
                if indexPath.row == 4 {
                    
                    if let dur = self.jobsArr.finalCallDuration
                    {
                        if dur > 0
                        {
                            return UITableView.automaticDimension
                        }
                    }
                    
                   return 0
                }
      
            }
        return UITableView.automaticDimension
        }
    
@objc func invoiceDwnload()
{
    if let bill = self.jobsArr.finalBill
    {
        if let url = URL(string: bill) {
            UIApplication.shared.open(url)
        }
    }
    
}
    
    
    
  //MARK:  TranslatorLinkCellDelegate
    func translatorLinkClicked()
    {
        if let url = URL(string: "https://targoworldreact.web.app/uploaddocument/\(self.jobId)/\(userType)") {
                   UIApplication.shared.open(url)
               }
    }
      func copyButtonClicked()
      {
        let shareStr = "https://targoworldreact.web.app/uploaddocument/\(self.jobId)/\(userType)"
        let pasteboard = UIPasteboard.general
        AppUtils.showToast(message: "urlCpyKey".localizableString(loc: Constant.lang))
        pasteboard.string = shareStr
    }
      func shareButtonClicked()
      {
        let share = ["Upload documents on https://targoworldreact.web.app/uploaddocument/\(self.jobId)/\(userType)"]
               let ac = UIActivityViewController(activityItems: share, applicationActivities: nil)
               ac.setValue("Upload link", forKey: "subjectKey".localizableString(loc: Constant.lang))
               // present(ac, animated: true)
               self.present(ac, animated: true, completion: nil)
    }
    
    
    
}

extension JobDetailViewController
{
    //JobDetail Post Api
    func JobDetail()
    {
        Utils.startLoading(self.view)
        let url:String = "\(Constant.APIs.baseURL)/jobdetail"
        let request:[String:Any] = ["jobId": jobId]
        
        Service.sharedInstance.postRequest(Url:url,modalName: jobDetailModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        
                        self.transDoc.removeAll()
                        
                        
                        if let doc = response?.translatedDoc?.documents
                        {
                            self.transDoc = doc
                        }
                        
                        self.jobsArr = (response?.job)!
                        self.jobStatus = self.jobsArr.jobStatus
                        
                    }
                    self.jobDeTV.reloadData()
                }}
        }
    }
    
    //jobStatus Post Api
    func jobStatusApi(jobStatus: Int)
    {
        
        Utils.startLoading(self.view)
        let url:String = "\(Constant.APIs.baseURL)/changejobstatus"
        let request:[String:Any] = ["jobId": jobId,
                                    "jobStatus": jobStatus]
        
        Service.sharedInstance.postRequest(Url:url,modalName: approvedDocModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        AppUtils.showToast(message: (response?.Message)!)
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                    self.jobDeTV.reloadData()
                    self.JobDetail()
                }}
            
        }
    }
    
    
    //jobAccept Post Api
    func jobAcceptApi()
    {
        
        Utils.startLoading(self.view)
        
        let id = Constant.appDel.userId
        
        let request:[String:Any] = ["acceptedBy":id,
                                    "jobId": jobId
        ]
        
        var url = Constant.APIs.jobacceptedby
        
        if self.jobsArr.isUrgentJob == true
        {
            url = Constant.APIs.urgentJobAcceptedby
        }
 
        Service.sharedInstance.postRequest(Url:url,modalName: approvedDocModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "PostJob"), object: nil)
                        AppUtils.showToast(message: (response?.Message)!)
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                    self.jobDeTV.reloadData()
                    self.JobDetail()
                }}
        }
    }
}


extension JobDetailViewController : JobDetailDelegate
{
    
    func linkClicked() {
        if let url = URL(string: "https://www.targo.world/\(self.jobId)/\(AppUtils.AppDelegate().userId)") {
            UIApplication.shared.open(url)
        }
    }
    func copyBtnClicked() {
        let shareStr = "Join using https://www.targo.world/ \n Meeting id is \(self.jobsArr.jobNumber!)"
        let pasteboard = UIPasteboard.general
        AppUtils.showToast(message: "urlCpyKey".localizableString(loc: Constant.lang))
        pasteboard.string = shareStr
    }
    
    func shareBtnClicked() {
        let share = ["Join using https://www.targo.world/ \n Meeting id is \(self.jobsArr.jobNumber!)"]
        let ac = UIActivityViewController(activityItems: share, applicationActivities: nil)
        ac.setValue("meetngLnkKey".localizableString(loc: Constant.lang), forKey: "subjectKey".localizableString(loc: Constant.lang))
        // present(ac, animated: true)
        self.present(ac, animated: true, completion: nil)
    }
    
}



