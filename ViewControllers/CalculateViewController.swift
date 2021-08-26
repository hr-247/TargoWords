//
//  CalculateViewController.swift
//  TolkApp
//
//  Created by sanganan on 7/10/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
import DatePickerDialog
import McPicker

class CalculateViewController: UIViewController{
    
    //variables
    var dateTimeVar : String? = ""
    var whPicker = Bool()
    //   var tiId = ""
    var jobCreaterId = ""
    var jobId = ""
    var duration = 0
    var waiting = 0
    var startTimeStamp = 0
    var endTimeStamp = 0
    var jobDate = 0
    
    
    //MARK:- outlets
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var durationTF: UITextField!
    @IBOutlet weak var waitingTime: UITextField!
    @IBOutlet weak var markSComplteBtn: UIButton!
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.calDurVCT, controller: Constant.Controllers.calculate)
        
        startTime.placeholder = "strtTmeKey".localizableString(loc: Constant.lang)
        endTime.placeholder = "endTmeKey".localizableString(loc: Constant.lang)
        durationTF.placeholder = "callDurKey".localizableString(loc: Constant.lang)
        waitingTime.placeholder = "waitTmeKey".localizableString(loc: Constant.lang)
        
        markSComplteBtn.setTitle("nxtKey".localizableString(loc: Constant.lang), for: .normal)
//        let   dateTimeFormat = "hh:mm a"
        startTime.text = AppUtils.timestampToDate1(timeStamp: Double(jobDate))
         
        
        startTime.delegate  = self
        endTime.delegate  = self
        waitingTime.delegate  = self
        
        durationTF.isUserInteractionEnabled = false
        markSComplteBtn.backgroundColor = UIColor.undrC
        
    }
//    @objc func startTimeActn()
//    {
//
//    }
//    @objc func endTimeActn()
//    {
//        self.view.endEditing(true)
//        whPicker =  true
//        datePickerTapped(picker: whPicker)
//    }
//
//    @objc func waitingTimeActn()
//    {
//        self.view.endEditing(true)
//        durationPickerTapped()
//    }
    
    @IBAction func completeJobActn(_ sender: Any) {
        
        if startTime.text == "" ||  endTime.text == "" ||  durationTF.text == "" ||  waitingTime.text == ""{
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
            return
        }else{
            
            let vc = Constant.Controllers.signature.get() as! SignatureViewController
            vc.startTime = self.startTime.text!
            vc.endTime = self.endTime.text!
            vc.duration = self.durationTF.text!
            vc.waitTime = self.waitingTime.text!
            vc.waiting = self.waiting
            vc.jobId = self.jobId
            vc.durationInt = self.duration
            vc.jobCreaterId = self.jobCreaterId
            vc.startTimeStamp = self.startTimeStamp
            vc.endTimeStamp = self.endTimeStamp
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
        }
    }
    
}

extension CalculateViewController
{
    
    func datePickerTapped(picker: Bool) {
        
        let picker = DatePickerDialog()
        picker.show("Date & Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: Date(), minimumDate: nil, maximumDate: Date(), datePickerMode: .time) {
            (date) -> Void in
            if let dt = date {
                let   dateTimeFormat = "hh:mm a"
                self.dateTimeVar = AppUtils.getParticularTimeFormat(format: dateTimeFormat, date: dt)
                
                if self.whPicker == false
                {
                    self.startTimeStamp = Int(dt.secondsSince1970)
                    self.startTime.text = self.dateTimeVar
                   
                }else{
                    if self.startTime.text == ""{
                        self.endTime.text = ""
                        AppUtils.showToast(message: "Please select start time first.")
                        return
                    }
                    self.endTimeStamp = Int(dt.secondsSince1970)
                    
                    self.endTime.text = self.dateTimeVar
                    
                    let diff = AppUtils.CompareDate1(time1Str: self.startTime.text!, time2Str: self.endTime.text!)
                    if diff <= 0{
                        self.endTime.text = ""
                        AppUtils.showToast(message: "End time should be greater than start time.")
                        return
                    }else{
                        
                        let output = AppUtils.findDateDiff(time1Str: self.startTime.text!, time2Str: self.endTime.text!)
                        self.duration = output.1
                        self.durationTF.text = output.0
                    }
                }
                
                
            }
            
            
        }
    }
    
    
    func durationPickerTapped()
    {
        let array = classConst.waitingTimeArr
        McPicker.show(data: [array]) {  [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                self?.waiting = Int(name)!
            
                self?.waitingTime.text = "\(name) Minutes"
                
            }
        }
    }
    
    
}
extension CalculateViewController
{
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.startTime {
            whPicker =  false
            datePickerTapped(picker: whPicker)
            
        }else if textField == self.endTime
        {
            whPicker =  true
            datePickerTapped(picker: whPicker)
        }else if textField == self.waitingTime
        {
            self.durationPickerTapped()
        }
        
        return false
    }
    
}


