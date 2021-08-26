//
//  ApprovalPViewController.swift
//  TolkApp
//
//  Created by sanganan on 5/29/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class ApprovalPViewController: UIViewController {
    
    
    @IBOutlet weak var dscTxtVw: UITextView!
    
    @IBOutlet weak var approvedLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dscTxtVw.text = "dscforApprvlKey".localizableString(loc: Constant.lang)
        
        approvedLbl.text = "approvalPendngKey".localizableString(loc: Constant.lang)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

}
