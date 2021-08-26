//
//  OtherViewController.swift
//  TolkApp
//
//  Created by sanganan on 7/2/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController {
    
    
    @IBOutlet weak var creditBtn: UIButton!
    @IBOutlet weak var payHistoryBtn: UIButton!
    @IBOutlet weak var viewCreditsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.otherVCT, controller: Constant.Controllers.other)
        payHistoryBtn.setTitle("paymntHistoryKey".localizableString(loc: Constant.lang), for: .normal)
        
        viewCreditsBtn.setTitle("creditCardsKey".localizableString(loc: Constant.lang), for: .normal)
        self.payHistoryBtn.backgroundColor = UIColor.undrC
        self.viewCreditsBtn.backgroundColor = UIColor.undrC
        
        if let str = AppUtils.getStringForKey(key: Constant.userData.userType!)
               {
                   if str == "1004" {
                   }else
                   {
                    self.creditBtn.setTitle("paymntDetailsKey".localizableString(loc: Constant.lang), for: .normal)
                   }
               }
    }
    
    @IBAction func payHistryActn()
      {
       let vc = Constant.Controllers.paymentHistory.get() as! PaymentHistoryViewController
       self.navigationController?.pushViewController(vc, animated: true)
       }
       @IBAction func viewCardsActn()
       {
        
        if let str = AppUtils.getStringForKey(key: Constant.userData.userType!)
        {
            if str == "1004" {
                let vc = Constant.Controllers.cardDetails.get() as! CardDetailsViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else
            {
             // push to account page here
                let vc = Constant.Controllers.account.get() as! AccountDetailController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        
          
       }

}
