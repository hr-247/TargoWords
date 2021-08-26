//
//  JobDetailButtonsTableViewCell.swift
//  TolkApp
//
//  Created by sanganan on 7/7/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

protocol JobDetailDelegate {
    func linkClicked()
    func copyBtnClicked()
    func shareBtnClicked()

}

class JobDetailButtonsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var linkBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var copyBtn: UIButton!
    @IBOutlet weak var accptBtn: UIButton!
    @IBOutlet weak var cancelledLbl: UILabel!
    @IBOutlet weak var rjctBtn: UIButton!
    @IBOutlet weak var rejectedLbl: UILabel!
    @IBOutlet weak var completedLbl: UILabel!
    @IBOutlet weak var completeJob: UIButton!
    @IBOutlet weak var translatedDocBtn: UIButton!
    @IBOutlet weak var codeLbl: UILabel!
    
    
    var delegate : JobDetailDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        cancelledLbl.backgroundColor = UIColor.navBarC
        linkBtn.tintColor = UIColor.navBarC
        shareBtn.backgroundColor = UIColor.navBarC
        copyBtn.backgroundColor = UIColor.navBarC
        codeLbl.backgroundColor = UIColor.undrC
    }

   @IBAction func linkTapped(_ sender: Any) {
            self.delegate?.linkClicked()
        }
        @IBAction func copyButtonTapped(_ sender: Any) {
            self.delegate?.copyBtnClicked()
            AppUtils.showToast(message: Constant.Msg.urlCpyMsg)
        }
        
        @IBAction func shareBtnTapped(_ sender: Any) {
            self.delegate?.shareBtnClicked()
        }
    }

