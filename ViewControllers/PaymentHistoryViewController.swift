//
//  PaymentHistoryViewController.swift
//  TolkApp
//
//  Created by sanganan on 7/2/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class PaymentHistoryViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var paymentTV: UITableView!
    @IBOutlet weak var noHistoryLbl: UILabel!
    @IBOutlet weak var histryDetailsHeadng: UILabel!
    var userType : String = ""

    
    //Variables
    var payHistoryArr = [PaymentModal]()
    var payHistoryTI = [PaymentRecords]()

    private var moreData : Bool = false
    private var pageNo : Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.payHisVCT, controller: Constant.Controllers.paymentHistory)
        histryDetailsHeadng.text = "histryDtlsKey".localizableString(loc: Constant.lang)
        noHistoryLbl.isHidden  = true
        Utils.startLoading(self.view)
        
        if let uType = AppUtils.getStringForKey(key: Constant.userData.userType!)
        {
            userType = uType
        }
        
        if userType == "1004"
        {
            paymentHistoryApi(pageN: pageNo)
        }else
        {
            paymentHistoryApiForTI(pageN: pageNo)
        }
        
        paymentTV.register(UINib(nibName: "PaymentHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "PaymentHistoryTableViewCell")
        paymentTV.register(UINib(nibName: "BlankTableViewCell", bundle: nil), forCellReuseIdentifier: "BlankTableViewCell")
        paymentTV.delegate = self
        paymentTV.dataSource = self
    }
    
    
    
}
extension PaymentHistoryViewController : UITableViewDataSource,UITableViewDelegate
{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
         if moreData == true{
             return 2
        }
                
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if section == 0 {
        if userType == "1004"
        {
                 return payHistoryArr.count
        }
            
          return payHistoryTI.count
            
            
        }else{
            return 1
        }
        
       
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        if indexPath.section == 0
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentHistoryTableViewCell", for: indexPath) as! PaymentHistoryTableViewCell
            
            
            
            if userType == "1004" {
                   
            if let jobType = payHistoryArr[indexPath.row].job?.jobType
            {
                if jobType == 1002
                {
//                    cell.durationH.isHidden = true
//                    cell.durationLbl.isHidden = true
//                    cell.modeLbl.isHidden = true
//                    cell.durationHeight.constant = 0
//                    cell.space1.constant = 0
//                    cell.space2.constant = 0
//                    cell.modeH.isHidden = true
//                    cell.modeHeight.constant = 0
                    
                   // cell.modeH.text = "Translation"
                    cell.durationH.text = "No. of words:"
                    
                    if let words = payHistoryArr[indexPath.row].job?.finalNoOfWords
                    {
                        cell.durationLbl.text = "\(words)"
                    }
                    
                    cell.modeLbl.text = "Translation"
                    
                    
                }else{
                   // cell.modeH.text = "Mode:"
                    cell.durationH.text = "Duration:"
//                    cell.durationH.isHidden = false
//                    cell.durationLbl.isHidden = false
//                    cell.modeLbl.isHidden = false
//                    cell.modeH.isHidden = false
                    if let dur = payHistoryArr[indexPath.row].job?.duration
                              {
                                  cell.durationLbl.text = "\(dur/60) \(Constant.Common.minsTxt)"
                              }
                    if let mode = payHistoryArr[indexPath.row].job?.jobServiceType
                               {
                                   cell.modeLbl.text = Constant.getMode(mode: mode)
                               }
                }
            }
            
            
          
           
            if let addr = payHistoryArr[indexPath.row].job?.address
            {
                cell.locationLbl.text = addr
            }
            if let jobNo = payHistoryArr[indexPath.row].job?.jobNumber
            {
                cell.jobNum.text = "\(jobNo)"
            }
            if let date = payHistoryArr[indexPath.row].job?.jobDate
            {
                cell.dateLbl.text = AppUtils.timestampToDate(timeStamp: Double(date))
            }
            if let ref = payHistoryArr[indexPath.row].type
            {
                if ref == "refund"
                {
                    cell.paymntStatusLbl.text = ref
                }else{
                    if let payStatus = payHistoryArr[indexPath.row].job?.paymentStatus
                    {
                        cell.paymntStatusLbl.text = payStatus
                    }
                }
            }
            if let str = AppUtils.getStringForKey(key: Constant.userData.userType!)
            {
                
                if str == "1004" {
                    
                    if let refund = payHistoryArr[indexPath.row].refund
                    {
                        if refund != 0
                        {
                            cell.amountLbl.text = "CR € \(String(format: "%.2f", refund))"
                        }
                    else{
                        
                        if let amount = payHistoryArr[indexPath.row].amountforJobCreator
                        {
                            cell.amountLbl.text = "DR € \(String(format: "%.2f", amount))"
                        }
                    }
                    }
                }else
                {
                    if let amount = payHistoryArr[indexPath.row].amountforTI
                    {
                        cell.amountLbl.text = "CR € \(String(format: "%.2f", amount))"
                    }
                    
                }
                
            }
                
            }else
            {
                // TI
                
                let record = payHistoryTI[indexPath.row]
                
                 if let jobType = record.jobType
                            {
                                if jobType == 1002
                                {
                
                                    cell.durationH.text = "No. of words:"
                                    
                                    if let words = record.finalNoOfWords
                                    {
                                        cell.durationLbl.text = "\(words)"
                                    }
                                    
                                    cell.modeLbl.text = "Translation"
                                    
                                    
                                }else{
                                   // cell.modeH.text = "Mode:"
                                    cell.durationH.text = "Duration:"
              
                                    if let dur = record.finalCallDuration
                                              {
                                                  cell.durationLbl.text = "\(dur/60) \(Constant.Common.minsTxt)"
                                              }
                                    if let mode = record.jobType
                                               {
//                                                   cell.modeLbl.text = Constant.getMode(mode: mode)
                                                cell.modeLbl.text = "Interperter"

                                               }
                                }
                            }
                cell.jobNum.text = "\(record.jobNumber!)"
                if let date = record.jobDate
                {
                    cell.dateLbl.text = AppUtils.timestampToDate(timeStamp: Double(date))
                }
                
                if let amount = record.tiPayment
                {
                     cell.amountLbl.text = "CR € \(String(format: "%d", amount))"
                }
                
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlankTableViewCell", for: indexPath) as! BlankTableViewCell
            for viw in cell.subviews
            {
                if viw is UIActivityIndicatorView
                {
                    let indicatr = viw as! UIActivityIndicatorView
                    indicatr.removeFromSuperview()
                    break
                }
            }
            cell.addSubview(AppUtils.activityIndicator())
            cell.backgroundColor = UIColor.clear;
            cell.tag = 99999
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.tag == 99999 {
            self.pageNo += 1
            if userType == "1004"
                   {
                       paymentHistoryApi(pageN: pageNo)
                   }else
                   {
                       paymentHistoryApiForTI(pageN: pageNo)
                   }
        }
    }
}
extension PaymentHistoryViewController
{
    
    //Payment History FOr TI
    func paymentHistoryApiForTI(pageN : Int)
    {
        
        let request:[String:Any] = ["userId" : Constant.appDel.userId,
                                    "pageNo": pageN]
        
        Service.sharedInstance.postRequest(Url:Constant.APIs.geTIpayments, modalName: PaymentTIModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if pageN == 1
                {
                    self.payHistoryArr.removeAll()
                }
                if let res = response?.Success{
                    if res == 1{
                        
                        
                        let tempArr = response!.paymentList
                        
                        self.payHistoryTI = self.payHistoryTI + tempArr
                        
                        
                        
                        if self.payHistoryTI.count == 0 {
                            self.noHistoryLbl.isHidden = false
                            self.noHistoryLbl.text = "noHisFoundKey".localizableString(loc: Constant.lang)
                            
                        }
                        else {
                            self.noHistoryLbl.isHidden = true
                        }
                        
                        if tempArr.count < 10
                        {
                            self.moreData = false
                        }else{
                            self.moreData = true
                        }
                        
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                    self.paymentTV.reloadData()
                }
            }}
        
    }
    
    
    
    
    
    
    
    
    //Payment History FOr Job Creator
    func paymentHistoryApi(pageN : Int)
    {
        
        let request:[String:Any] = ["userId" : Constant.appDel.userId,
                                    "pageNo": pageN]
        
        Service.sharedInstance.postRequest(Url:Constant.APIs.getmypayments,modalName: PaymentHistoryModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if pageN == 1
                {
                    self.payHistoryArr.removeAll()
                }
                if let res = response?.Success{
                    if res == 1{
                        
                        
                        let tempArr = response!.paymentList
                        
                        self.payHistoryArr = self.payHistoryArr + tempArr
                        
                        
                        
                        if self.payHistoryArr.count == 0 {
                            self.noHistoryLbl.isHidden = false
                            self.noHistoryLbl.text = "noHisFoundKey".localizableString(loc: Constant.lang)
                            
                        }
                        else {
                            self.noHistoryLbl.isHidden = true
                        }
                        
                        if tempArr.count < 10
                        {
                            self.moreData = false
                        }else{
                            self.moreData = true
                        }
                        
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                    self.paymentTV.reloadData()
                }
            }}
        
    }
}
