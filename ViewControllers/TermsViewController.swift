//
//  TermsViewController.swift
//  TolkApp
//
//  Created by sanganan on 7/16/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {
    
    //Variables
    var phoneNmbr = ""
    
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.tnCVCT, controller: Constant.Controllers.tnC)
        
        agreeBtn.setTitle("agreeKey".localizableString(loc: Constant.lang), for: .normal)
        
        cancelBtn.setTitle("CancelKey".localizableString(loc: Constant.lang), for: .normal)
        
        agreeBtn.backgroundColor = UIColor.navBarC
        cancelBtn.backgroundColor = UIColor.undrC
    }
    
    @IBAction func agreeActn()
    {
        let vc = Constant.Controllers.register.get() as! RegisterViewController
        vc.phoneNmbr = self.phoneNmbr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func cancelActn()
    {
       let vc = Constant.Controllers.verNo.get() as! VerifyNumViewController
       self.navigationController?.pushViewController(vc, animated: true)
       
    }
}
