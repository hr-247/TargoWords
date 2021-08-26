//
//  DocRejectViewController.swift
//  TolkApp
//
//  Created by sanganan on 6/16/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class DocRejectViewController: UIViewController {
    
    @IBOutlet weak var rejectReasonLbl: UILabel!
    
    @IBOutlet weak var rejctedHeading: UILabel!
    
    @IBOutlet weak var uploadDocAgain: UIButton!
    var rejectReason = ""
    var userData : UserDetail?


    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
       // commonNavigationBar(title: "", controller: Constant.Controllers.docRej)
        rejectReasonLbl.text = rejectReason
        rejctedHeading.text = "docRjctedKey".localizableString(loc: Constant.lang)
        uploadDocAgain.setTitle("uploadDocAgainKey".localizableString(loc: Constant.lang), for: .normal)
        
        uploadDocAgain.backgroundColor = UIColor.undrC
    }
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = true
       }
       override func viewWillDisappear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = false
       }

    @IBAction func uploadAgainActn(_ sender: UIButton) {
        
        let vc = Constant.Controllers.upDoc.get() as! UploadDocViewController
        vc.pageCheck = true
        vc.userData = self.userData
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
 
}
