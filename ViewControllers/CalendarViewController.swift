//
//  CalendarViewController.swift
//  TolkApp
//
//  Created by Ankit  Jain on 07/06/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
import VACalendar


class CalendarViewController: UIViewController {
    
    
    var jobsArr = [JobList]()
    var jobId : String = ""
    var jobStatus : Int = Int()
    var userType : Int = Int()
    var sourLanguage : String = String()
    var destLanguage : String = String()
    var jobDate : Int = Int()
    
    @IBOutlet weak var calenderTV: UITableView!
    @IBOutlet weak var noJobsLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    var calendarView: VACalendarView!
    @IBOutlet weak var weekDaysView: VAWeekDaysView!
    {
        didSet {
            let appereance = VAWeekDaysViewAppearance(symbolsType: .veryShort, calendar: defaultCalendar)
            weekDaysView.appearance = appereance
        }
    }
    @IBOutlet weak var monthHeaderView: VAMonthHeaderView!{
  
        didSet {
              let formattr = DateFormatter()
                  formattr.timeZone = .current
                  formattr.dateFormat = "MMMM yyyy"
            let appereance = VAMonthHeaderViewAppearance(
                monthTextColor : .black,
                previousButtonImage: #imageLiteral(resourceName: "prev"),
                nextButtonImage: #imageLiteral(resourceName: "next"),
                dateFormatter: formattr
            )
            monthHeaderView.backgroundColor = UIColor.undrC
            monthHeaderView.delegate = self
            monthHeaderView.appearance = appereance
        }
    }
    

    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        calendar.timeZone = .current
        return calendar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.calVCT, controller: Constant.Controllers.calendar)
        calenderTV.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        calenderTV.delegate = self
        calenderTV.dataSource = self

        self.setDateOnLbl(date: Date())

        let calendar = VACalendar(calendar: defaultCalendar)
               calendarView = VACalendarView(frame: .zero, calendar: calendar)
               calendarView.showDaysOut = true
        calendarView.backgroundColor = .white
               calendarView.selectionStyle = .single
               calendarView.monthDelegate = monthHeaderView
               calendarView.dayViewAppearanceDelegate = self
               calendarView.monthViewAppearanceDelegate = self
               calendarView.calendarDelegate = self
               calendarView.scrollDirection = .horizontal
               view.addSubview(calendarView)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           
           if calendarView.frame == .zero {
               calendarView.frame = CGRect(
                   x: 25,
                   y: weekDaysView.frame.maxY,
                   width: view.frame.width - 50,
                   height: 280
               )
               calendarView.setup()
           }
       }
    
    func setDateOnLbl(date : Date)
    {
        let formattr = DateFormatter()
        formattr.timeZone = .current
        formattr.dateFormat = "dd MMM yyyy"
        
        self.dateLbl.text = "   " + formattr.string(from: date)
        let date = date.secondsSince1970
        self.jobDate = Int(date)
        getmyjobs()
        
    }
   @objc func cancelActn()
   {
    
    }

}


extension CalendarViewController : VAMonthHeaderViewDelegate
{
    func didTapNextMonth() {
        calendarView.nextMonth()
    }
    
    func didTapPreviousMonth() {
        calendarView.previousMonth()
    }
    
}


extension CalendarViewController : VADayViewAppearanceDelegate
{
    
    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
        case .selected:
            return .white
        case .unavailable:
            return .lightGray
        default:
            return .black
        }
    }
    
    func textBackgroundColor(for state: VADayState) -> UIColor {
        switch state {
        case .selected:
            return UIColor.navBarC
        default:
            return .clear
        }
    }
    
    func shape() -> VADayShape {
        return .circle
    }
    
    func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
        switch state {
        case .selected:
            return 2
        default:
            return -7
        }
    }
    
}
extension CalendarViewController : VAMonthViewAppearanceDelegate
{
    func leftInset() -> CGFloat {
        return 10.0
    }
    
    func rightInset() -> CGFloat {
        return 10.0
    }
    
    func verticalMonthTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    func verticalMonthTitleColor() -> UIColor {
        return .black
    }
    
    func verticalCurrentMonthTitleColor() -> UIColor {
        return .red
    }
    
}
extension CalendarViewController : VACalendarViewDelegate
{
    func selectedDate(_ date: Date)
    {
        self.setDateOnLbl(date: date)
        print("selected date",date)
    }
    func selectedDates(_ dates: [Date])
    {
        print("selected dates",dates)

    }
}
extension CalendarViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jobsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
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
                
                cell.addrLbl.text = self.jobsArr[indexPath.row].address
                if  let dur = self.jobsArr[indexPath.row].duration
                {
                    cell.durationLbl.text = "\(dur) \(Constant.Common.minsTxt)"
                }
                
                let jbval =    self.jobsArr[indexPath.row].jobStatus
                
                cell.statusLbl.text = Constant.getJobStatus(status : jbval!)
                
                
                if  let jobNo = self.jobsArr[indexPath.row].jobNumber
                {
                    cell.jobNo.text = String(describing: jobNo)
                }

               
                cell.cancelBtn.tag = indexPath.row
                cell.cancelBtn.addTarget(self, action: #selector(cancelActn), for: .touchUpInside)
                 if jobsArr[indexPath.row].jobStatus == 4003
                      {
                          cell.cancelBtn.isHidden = true
                          cell.cancelledLbl.isHidden = false
                          cell.cancelledLbl.layer.cornerRadius = 15
                          cell.cancelledLbl.layer.masksToBounds = true
                          cell.cancelledLbl.text = "cancelledKey".localizableString(loc: Constant.lang)
                          
                      }
                      
                      if jobsArr[indexPath.row].jobStatus == 4004
                             {
                                 cell.cancelBtn.isHidden = true
                                 cell.cancelledLbl.isHidden = false
                                 cell.cancelledLbl.layer.cornerRadius = 15
                                 cell.cancelledLbl.layer.masksToBounds = true
                                cell.cancelledLbl.text = "completedKey".localizableString(loc: Constant.lang)

                                 
                             }
                      
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
extension CalendarViewController
{
    //getmyjobs Post Api
    func getmyjobs()
    {
        var type = 1004
        if let str = AppUtils.getStringForKey(key: Constant.userData.userType!)
        {
           type = Int(str)!
        }
        
        Utils.startLoading(self.view)
        let url:String = "\(Constant.APIs.baseURL)/jobatperticulardate"
        let uId = AppUtils.getStringForKey(key: Constant.userData.id)
        let request:[String:Any] = ["userId":  uId!,
                                    "jobDate": self.jobDate,
                                    "userType": type
        ]
        
        Service.sharedInstance.postRequest(Url:url,modalName: GetJobDetailModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
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
                        
                        if self.jobsArr.count == 0 {
                            
                            self.noJobsLbl.isHidden = false
                            self.noJobsLbl.text = "noJobKey".localizableString(loc: Constant.lang)
                        }
                        else {
                            
                            self.noJobsLbl.isHidden = true
                        }
                        
                        
                     //   AppUtils.showToast(message: (response?.Message)!)
                        
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                    self.calenderTV.reloadData()
                }}
            
        }
    }
}
