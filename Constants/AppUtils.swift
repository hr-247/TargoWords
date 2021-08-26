//
//  AppUtils.swift
//  TolkApp
//
//  Created by sanganan on 5/14/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
import Toaster

class AppUtils: NSObject {
    //MARK: appdelegate object
    static func AppDelegate() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    static func goToPreviousPage(navigation:UINavigationController?,whichPage:AnyObject)
    {
        if let nav = navigation
        {
            let navigationArray = nav.viewControllers
            for (index,item) in (navigationArray.enumerated())
            {
                if item.isKind(of: whichPage as! AnyClass)
                {
                    navigation?.popToViewController((navigation?.viewControllers[index])!, animated: true)
                }
            }
        }
    }
    static func showToast(message : String)
    {
        let toast = Toast(text: message, delay: 0.1, duration: 1.5)
        toast.view.backgroundColor = UIColor.darkGray
        toast.view.font = UIFont.systemFont(ofSize: 14)
        toast.show()
    }
    
    static func getStringForKey(key : String) -> String?
    {
        let defaultdata = UserDefaults.standard
        
        if let val =  defaultdata.value(forKey: key) as? String
        {
            return val
        }
        return nil
    }
    static func setStringForKey(key : String,val:String)
    {
        let defaultdata = UserDefaults.standard
        defaultdata.set(val, forKey: key)
        defaultdata.synchronize()
    }
    
    static func removeDataFrom(key : String)
    {
        let defaultdata = UserDefaults.standard
        defaultdata.removeObject(forKey: key)
        defaultdata.synchronize()
    }
    
    static func activityIndicator() -> UIActivityIndicatorView
    {
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        myActivityIndicator.frame = CGRect(x: (UIScreen.main.bounds.size.width-20)/2, y: 20, width: 20, height: 20)
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.style = .white
        myActivityIndicator.startAnimating()
        myActivityIndicator.color = UIColor.systemGray;
        return myActivityIndicator
    }
    
    static func stringToDictionary(_ strToJSON : String)-> NSDictionary!{
        print("JsonString:\(strToJSON)");
        let data = strToJSON.data(using: String.Encoding.utf8)
        
        var dict : NSDictionary!;
        do {
            
            dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            return dict;
        }
            
        catch let error as NSError {
            print("Error is:\(error)");
            
        }
        
        return dict;
    }
    static func timestampToDate(timeStamp : Double) -> String{
        
        var timeStr = "\(timeStamp)"
        
        if timeStr.contains(".") {
            timeStr = timeStr.components(separatedBy: ".")[0]
        }
        var timeInterval = Double(timeStr)!
        if timeStr.count >= 13
        {
            timeInterval = Double(timeStr)! / 1000.0
        }
        
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "d MMMM yyyy, hh:mm a" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    static func timestampToDate1(timeStamp : Double) -> String{
        
        var timeStr = "\(timeStamp)"
        
        if timeStr.contains(".") {
            timeStr = timeStr.components(separatedBy: ".")[0]
        }
        var timeInterval = Double(timeStr)!
        if timeStr.count >= 13
        {
            timeInterval = Double(timeStr)! / 1000.0
        }
        
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "hh:mm a" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    
    
    static func getParticularTimeFormat(format:String ,date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = format
        let strDate = dateFormatter.string(from: date)
        
        return String(describing: strDate)
    }
    static  func findDateDiff(time1Str: String, time2Str: String) -> (String, Int) {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "hh:mm a"
        
        guard let time1 = timeformatter.date(from: time1Str),
            let time2 = timeformatter.date(from: time2Str) else { return ("",0) }
        
        //You can directly use from here if you have two dates
        
        let interval = time2.timeIntervalSince(time1)
        let hour = Int(interval / 3600);
        let minute = Int(interval.truncatingRemainder(dividingBy: 3600) / 60)
        let intervalInt = Int(interval)
        
        print( interval,"interval")
        print( hour,"hour")
        print( minute,"minute")
        
        if hour == 0
        {
            if minute == 1
            {
                return ("\(Int(minute)) \(Constant.Common.minuteTxt)", intervalInt)
            }else{
                return ("\(Int(minute)) \(Constant.Common.minutesTxt)", intervalInt)
            }
        }
        else if minute == 0
        {
            if hour == 1
            {
                return ("\(Int(hour)) \(Constant.Common.hourTxt)", intervalInt)
            }else{
                return ("\(Int(hour)) \(Constant.Common.hoursTxt)", intervalInt)
            }
        }
        else if minute == 1  && hour == 1
        {
            return ("\(Int(hour)) \(Constant.Common.hourTxt) \(Int(minute)) \(Constant.Common.minuteTxt)", intervalInt)
        }
        else if hour == 1
        {
            return ("\(Int(hour)) \(Constant.Common.hourTxt) \(Int(minute)) \(Constant.Common.minutesTxt)", intervalInt)
        }
        else if minute == 1
        {
            return ("\(Int(hour)) \(Constant.Common.hoursTxt) \(Int(minute)) \(Constant.Common.minuteTxt)", intervalInt)
        }
            
        else{
            return ("\(Int(hour)) \(Constant.Common.hoursTxt) \(Int(minute)) \(Constant.Common.minutesTxt)", intervalInt)
        }
    }
    static  func CompareDate(time1Str: String, time2Str: String) -> Double {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "d MMMM yyyy, hh:mm a"
        
        let time1 = timeformatter.date(from: time1Str)
        let time2 = timeformatter.date(from: time2Str)
        
        //You can directly use from here if you have two dates
        
        let interval = time2!.timeIntervalSince(time1!)
        
        return interval
    }
    static  func CompareDate1(time1Str: String, time2Str: String) -> Int {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "hh:mm a"
        
        let time1 = timeformatter.date(from: time1Str)
        let time2 = timeformatter.date(from: time2Str)
        
        //You can directly use from here if you have two dates
        
        let interval = time2!.timeIntervalSince(time1!)
        
        return Int(interval)
    }
    
    
}


