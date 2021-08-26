//
//  Utils.swift
//  TrackApp
//
//  Created by saurav sinha on 25/11/19.
//  Copyright © 2019 Sanganan. All rights reserved.
//

import UIKit
import MBProgressHUD
import CoreLocation
import Contacts
import DKPhotoGallery


class Utils: NSObject,CLLocationManagerDelegate {
    
    
    var locationHandler : (CLLocation?, Error?) -> Void =
    {
        (loc,err) in
    }
    
    
    var refreshChanged : () -> Void =
    {
        () in
    }
    
   
    
    static var sharedInstance = Utils()
    static var progressView:MBProgressHUD?
    var locationManager: CLLocationManager!
    
    //MARK:- MBPROGRESSHUd
    static func startLoading(_ view : UIView)
    {
        UIApplication.shared.beginIgnoringInteractionEvents()
        progressView = MBProgressHUD.showAdded(to: view, animated: true);
        progressView?.animationType = .zoomIn
        progressView?.areDefaultMotionEffectsEnabled = true
        progressView?.isUserInteractionEnabled = false
        view.isUserInteractionEnabled = true
        
    }
    static func startLoadingWithText(_ strText: String, view : UIView)
    {
        progressView = MBProgressHUD.showAdded(to: view, animated: true);
        progressView?.label.text = strText;
        progressView?.isUserInteractionEnabled = false
    }
    
    static func changeLoadingWithText(_ strText: String)
    {
        progressView?.label.text = strText;
    }
    
    static func stopLoading()
    {
        if self.progressView != nil
        {
            self.progressView!.hide(animated: true)
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    static func stopLoadingInView(_ viw : UIView)
    {
        if self.progressView != nil
        {
            self.progressView!.hide(animated: true)
        }
        MBProgressHUD.hide(for: viw, animated: true)
    }

    

  
 // Location Manager helper stuff
    func initLocationManager() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Location Manager Delegate stuff
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("errorOfLocation:: \(error.localizedDescription)")
        locationHandler(nil,error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        else if status == .denied{
            
        }
        else if status == .notDetermined{
          
        }
        else if status == .restricted{
          
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.first != nil {
            
            locationHandler(locations.first,nil)
        }
        locationManager.stopUpdatingLocation();
    }
    
    static func authorizeLocationCheck(vc:UIViewController){
        
           if CLLocationManager.locationServicesEnabled() {
            
               switch CLLocationManager.authorizationStatus() {
                
               case .notDetermined, .restricted, .denied:
                let alertController = UIAlertController(title: "LocPermKey".localizableString(loc: Constant.lang), message: "grantPermKey".localizableString(loc: Constant.lang), preferredStyle: UIAlertController.Style.alert)
                   
                   let okAction = UIAlertAction(title: "SettingsKey".localizableString(loc: Constant.lang), style: .default, handler: {(cAlertAction) in
                       //Redirect to Settings app
                       UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                   })
                   
                   let cancelAction = UIAlertAction(title: "CancelKey".localizableString(loc: Constant.lang), style: UIAlertAction.Style.cancel)
                   alertController.addAction(cancelAction)
                   
                   alertController.addAction(okAction)
                   
                   vc.present(alertController, animated: true, completion: nil)
               case .authorizedAlways, .authorizedWhenInUse:
                   print("Access")
               @unknown default:
                   break
               }
           } else {
  //             print("Location services are not enabled")
            
            AppUtils.showToast(message: "notEnabldLocKey".localizableString(loc: Constant.lang))
      
           }
       }
    func getRegion(){
        let location = CLLocation(latitude: -22.963451, longitude: -43.198242)
        location.geocode { placemark, error in
            if let error = error as? CLError {
                print("CLError:", error)
                return
            } else if let placemark = placemark?.first {
                // you should always update your UI in the main thread
                DispatchQueue.main.async {
                    //  update UI here
                    print("name:", placemark.name ?? "unknown")

                    print("address1:", placemark.thoroughfare ?? "unknown")
                    print("address2:", placemark.subThoroughfare ?? "unknown")
                    print("neighborhood:", placemark.subLocality ?? "unknown")
                    print("city:", placemark.locality ?? "unknown")

                    print("state:", placemark.administrativeArea ?? "unknown")
                    print("subAdministrativeArea:", placemark.subAdministrativeArea ?? "unknown")
                    print("zip code:", placemark.postalCode ?? "unknown")
                    print("country:", placemark.country ?? "unknown", terminator: "\n\n")

                    print("isoCountryCode:", placemark.isoCountryCode ?? "unknown")
                    print("region identifier:", placemark.region?.identifier ?? "unknown")

                    print("timezone:", placemark.timeZone ?? "unknown", terminator:"\n\n")

                    // Mailind Address
                    print(placemark.mailingAddress ?? "unknown")
                }
            }
        }
    }
    
    
    func addRefreshControl() -> UIRefreshControl
    {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                     #selector(self.handleRefresh(_:)),
                                 for: .valueChanged)
            
        refreshControl.tintColor = UIColor.undrC
        
        return refreshControl
    }
    
   @objc func handleRefresh(_ refreshControl: UIRefreshControl) {

        refreshChanged()
    }
    
}

extension CLLocation {
    func geocode(completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(self, completionHandler: completion)
    }
}
extension Formatter {
    static let mailingAddress: CNPostalAddressFormatter = {
        let formatter = CNPostalAddressFormatter()
        formatter.style = .mailingAddress
        return formatter
    }()
}

extension CLPlacemark {
    var mailingAddress: String? {
        return postalAddress?.mailingAddress
    }
}

extension CNPostalAddress {
    var mailingAddress: String {
        return Formatter.mailingAddress.string(from: self)
    }
}



extension Utils
{
    
    static func imageTapped(index : Int, imageUrls : [URL], con : UIViewController)
    {
  
    let gallery = DKPhotoGallery()
    gallery.singleTapMode = .dismiss
        
    var items = [DKPhotoGalleryItem]()
    for url in imageUrls
    {
        let item = DKPhotoGalleryItem(imageURL: url)
        items.append(item)

        }
        
    gallery.items = items
  //  gallery.presentingFromImageView = self.imageView
    gallery.presentationIndex = index

//    gallery.finishedBlock = { dismissIndex, dismissItem in
//        if item == dismissItem {
//            return imageView
//        } else {
//            return nil
//        }
//    }

    con.present(photoGallery: gallery)
    }
    
}
