//
//  Extension.swift
//  HowrahBridge
//
//  Created by Ankit  Jain on 20/12/19.
//  Copyright © 2019 Sanganan. All rights reserved.
//

import UIKit
import AWSS3
import AVFoundation
import AWSCore
import Mantis
import CoreLocation


//MARK:- uifont extension
extension UIFont {
    static let titleExtraLarge: UIFont = font(ofSize: 34, weight: .semibold)
    
    static let titleLarge: UIFont = font(ofSize: 24, weight: .semibold)
    static let subtitleLarge: UIFont = font(ofSize: 24, weight: .regular)
    
    static let title: UIFont = font(ofSize: 18, weight: .semibold)
    static let subtitle: UIFont = font(ofSize: 18, weight: .regular)
    
    static let headline: UIFont = font(ofSize: 16, weight: .semibold)
    static let body: UIFont = font(ofSize: 16, weight: .regular)
    private static func font(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        return fontMetrics(forSize: size).scaledFont(for: .systemFont(ofSize: size, weight: weight))
    }
    private static func fontMetrics(forSize size: CGFloat) -> UIFontMetrics {
        switch size {
        case 34: return UIFontMetrics(forTextStyle: .largeTitle)
        case 24: return UIFontMetrics(forTextStyle: .title2)
        case 18: return UIFontMetrics(forTextStyle: .title3)
        case 14, 16: return UIFontMetrics(forTextStyle: .body)
        case 12: return UIFontMetrics(forTextStyle: .footnote)
        default: return UIFontMetrics.default
        }
    }
}

//MARK:- uicolor extension
extension UIColor {
    static let navBarC = UIColor(red: 25/255, green: 35/255, blue: 79/255, alpha: 1.0)
    static let undrC = UIColor(red: 185/255, green: 147/255, blue: 110/255, alpha: 1.0)
    static let txtFldC = UIColor.black
    static let plcholC = UIColor(red: 196/255, green: 197/255, blue: 199/255, alpha: 1.0)
    
}
extension UITextField{
    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width-10, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UIViewController {
    
    
    
    func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
                let location = placemarks.first?.location?.coordinate else {
                    completion(nil)
                    return
            }
            completion(location)
        }
    }
    
    
    //MARK:- Upload To AWS
    func uploadImageToAWS(_ img:UIImage, completion: @escaping (String?,Error?) -> ())
    {
        // getting local path
        Utils.startLoading(self.view)
        let image = awsUpload(image: img)
        let S3BucketName: String = Constant.bucketName
        var imageURL = NSURL()
        let imageName:String! = "tolk"
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
        let localPath = (documentDirectory as NSString).appendingPathComponent(imageName!)
        let data = image.jpegData(compressionQuality: 0.1)
        do {
            try     data!.write(to: URL(fileURLWithPath: localPath), options: .atomic)
            
        } catch
        {
            print(error)
        }
        imageURL = NSURL(fileURLWithPath: localPath)
        var _: AWSS3TransferUtilityUploadCompletionHandlerBlock?
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        
        let currentTimeStamp = NSDate().timeIntervalSince1970
        
        uploadRequest?.uploadProgress = {(bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
            DispatchQueue.main.async(execute: {() -> Void in
                
            })
        }
        
        let key : String = Constant.appDel.userId + String(describing: currentTimeStamp) + "_pic.png"
        
        print(key)
        uploadRequest?.body = imageURL as URL
        uploadRequest?.key = key
        uploadRequest?.bucket = S3BucketName
        uploadRequest?.contentType = "image/" + ".png"
        let transferManager = AWSS3TransferManager.default()
        transferManager.upload(uploadRequest!).continueWith { (task) -> AnyObject? in
            DispatchQueue.main.async {
                Utils.stopLoading()
            }
            
            if task.error != nil
            {
                AppUtils.showToast(message: "errInUploadKey".localizableString(loc: Constant.lang))
                DispatchQueue.main.async {
                    completion(nil,task.error)
                }            }
            else
            {
                if task.result != nil
                {
                    
                    DispatchQueue.main.async {
                        completion("https://s3.us-east-2.amazonaws.com/\(Constant.bucketName)/\(key)",nil)
                    }
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        completion(nil,task.error)
                    }
                    AppUtils.showToast(message: "errInUploadKey".localizableString(loc: Constant.lang))
                }
                
            }
            return nil
        }
    }
    
    
    
    func awsUpload(image:UIImage) -> UIImage
    {
        var croppedImage = image
        if image.size.width > 1242
        {
            let factor = image.size.width / 1242
            croppedImage =  image.scaleImageToSize(newSize: CGSize(width: 1242, height: image.size.height/factor))
        }
        else if image.size.height > 2436
        {
            let factor = image.size.height / 2436
            croppedImage =  image.scaleImageToSize(newSize: CGSize(width: image.size.width/factor, height: 2436))
        }
        
        return croppedImage
    }
}
extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    var secondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}



extension UIDevice {
    var isSimulator: Bool {
        #if IOS_SIMULATOR
            return true
        #else
            return false
        #endif
    }
}
