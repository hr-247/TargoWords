//
//  ViewController.swift
//  TolkApp
//
//  Created by sanganan on 5/14/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var homeTV: UITableView!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var noJobsLbl: UILabel!
    
    
    //MARK:-Variables
    var jobsArr = [JobList]()
    var jobId : String = ""
    var jobStatus : Int = Int()
    var userType : String = String()
    var sourLanguage : String = String()
    var destLanguage : String = String()
    var refreshControl = UIRefreshControl()
    
    //MARK:- viewDIdLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.homeVCT, controller: Constant.Controllers.home)
        if let str = AppUtils.getStringForKey(key: Constant.userData.userType!)
        {
        self.userType = str
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.postJobActn(_:)), name: NSNotification.Name(rawValue:"PostJob"), object: nil)
        Utils.startLoading(self.view)
       // getmyjobs()
        homeTV.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        homeTV.backgroundView = UIImageView(image: UIImage(named: "whitebg"))
        homeTV.delegate = self
        homeTV.dataSource = self
        
        noJobsLbl.text = "noJobKey".localizableString(loc: Constant.lang)
        
        refreshControl = Utils.sharedInstance.addRefreshControl()
        self.homeTV.refreshControl = refreshControl
        Utils.sharedInstance.refreshChanged = { () in
            self.getmyjobs()
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        if let str = AppUtils.getStringForKey(key: Constant.userData.userType!)
        {
            if str == "1004" {
                self.plusBtn.isHidden = false
            }else
            {
                self.plusBtn.isHidden = true
            }
        }
         getmyjobs()
    }
    
    @IBAction func createJb(_ sender: Any) {
        
        let cardVal = AppUtils.getStringForKey(key: Constant.userData.creditCardVal)
        if cardVal == "1"
        {
            let vc = Constant.Controllers.postJob.get() as! PostJobViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
            AppUtils.showToast(message: Constant.Msg.crdFrstMsg)
        }
 
    }
    
    @objc func postJobActn(_ notifi: NSNotification)
    {
        self.view.endEditing(true)
        self.getmyjobs()
    }
    
    @objc func cancelActn(_ sender: UIButton)
    {
        jobStatusApi(jbStatus: 4003)
    }

}
extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jobsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.cancelBtn.isHidden = false
        cell.cancelledLbl.isHidden = true
        
        let jobStatus = jobsArr[indexPath.row].jobStatus
        
        if userType == "1000" || userType == "1002" || userType == "1003"
        {
            
            if  jobStatus == 4000
            {
                cell.cancelBtn.isHidden = false
            }else{
                cell.cancelBtn.isHidden = true
            }
          
        }
      
        
        else if jobStatus == 4003
        {
            cell.cancelBtn.isHidden = true
            cell.cancelledLbl.isHidden = false
            cell.cancelledLbl.layer.cornerRadius = 15
            cell.cancelledLbl.layer.masksToBounds = true
            cell.cancelledLbl.text = "Cancelled"
            
        }
        
       
        if jobsArr[indexPath.row].jobStatus == 4004
               {
                   cell.cancelBtn.isHidden = true
                   cell.cancelledLbl.isHidden = false
                   cell.cancelledLbl.layer.cornerRadius = 15
                   cell.cancelledLbl.layer.masksToBounds = true
                   cell.cancelledLbl.text = "Completed"

                   
               }
        
        
        if let job = self.jobsArr[indexPath.row]._id
        {
            self.jobId = job
        }
        if  let date = self.jobsArr[indexPath.row].jobDate
        {
            cell.dateLbl.text  = AppUtils.timestampToDate(timeStamp: Double(date))
        }
        
        if let sLang = self.jobsArr[indexPath.row].sourceLanguage?.language
        {
            self.sourLanguage = sLang
        }
        
        if let dLang = self.jobsArr[indexPath.row].destinationLanguage?.language
        {
            self.destLanguage = dLang
        }
        //        if self.sourLanguage == nil || self.destLanguage != nil
        //        {
        cell.langLbl.text = "\(self.sourLanguage)-\(self.destLanguage)"
        //        }else{
        //            cell.langLbl.isHidden = true
        //        }
        cell.langLbl.textColor = UIColor.navBarC
        
        cell.addrLbl.text = self.jobsArr[indexPath.row].address
        
        if self.jobsArr[indexPath.row].jobType == 1000
        {
            cell.durLbl.text = "\("durationK".localizableString(loc: Constant.lang)) :"
            if  let dur = self.jobsArr[indexPath.row].duration
            {
                cell.durationLbl.text = "\(dur/60) \(Constant.Common.minsTxt)"
            }
        }else{
            cell.durLbl.text = "\("wordsK".localizableString(loc: Constant.lang)) :"
            if let words = self.jobsArr[indexPath.row].noOfWords
            {
                cell.durationLbl.text = "\(words)"
            }
        }
    //    let jbval =    self.jobsArr[indexPath.row].jobStatus
        
        cell.statusLbl.text = Constant.getJobStatus(status : jobStatus!)
        
        
        if  let jobNo = self.jobsArr[indexPath.row].jobNumber
        {
            cell.jobNo.text = String(describing: jobNo)
        }
        
        
        cell.cancelBtn.tag = indexPath.row
        cell.cancelBtn.addTarget(self, action: #selector(cancelActn), for: .touchUpInside)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Constant.Controllers.jobD.get() as! JobDetailViewController
        if let job = self.jobsArr[indexPath.row]._id
        {
            self.jobId = job
        }
        vc.jobId = self.jobId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController
{
    //getmyjobs Post Api
    func getmyjobs()
    {
        var userType = "1004"
        if let str = AppUtils.getStringForKey(key: Constant.userData.userType!)
               {
                  userType = str
               }
        
        let url:String = "\(Constant.APIs.baseURL)/getmyjobs"
        let uId = AppUtils.getStringForKey(key: Constant.userData.id)
        let request:[String:Any] = ["userId":  uId!, "userType":userType]
        
        Service.sharedInstance.postRequest(Url:url,modalName: GetJobDetailModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        
                        
                        let urgentJobs = (response?.urgentJobLists)!
                        
                        
                        self.jobsArr = (response?.jobLists)!
                        
                        
                        for item in urgentJobs
                        {
                            if let job = item.job
                            {
                                self.jobsArr.append(job)
                            }
                            
                        }
                        
                        
                        
//                        self.jobsArr = self.jobsArr + urgetnJobs
                        
                        
                        if self.jobsArr.count == 0 {
                            
                            self.noJobsLbl.isHidden = false
                            
                            
                        }
                        else {
                            
                            self.noJobsLbl.isHidden = true
                        }
                        
                        
                        //   AppUtils.showToast(message: (response?.Message)!)
                        
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                    
                    self.homeTV.reloadData()
                }}
            
        }
    }
    
    
    func jobStatusApi(jbStatus: Int)
    {
        
        
        Utils.startLoading(self.view)
        let url:String = "\(Constant.APIs.baseURL)/changejobstatus"
        let request:[String:Any] = ["jobId": self.jobId,
                                    "jobStatus": jbStatus]
        
        Service.sharedInstance.postRequest(Url:url,modalName: approvedDocModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        AppUtils.showToast(message: (response?.Message)!)
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                    self.getmyjobs()
                    // self.homeTV.reloadData()
                }}
            
        }
    }
}




