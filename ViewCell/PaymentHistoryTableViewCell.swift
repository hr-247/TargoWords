//
//  PaymentHistoryTableViewCell.swift
//  TolkApp
//
//  Created by sanganan on 7/2/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class PaymentHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var modeLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var jobNum: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var durationH: UILabel!
    @IBOutlet weak var durationHeight: NSLayoutConstraint!
    @IBOutlet weak var space1: NSLayoutConstraint!
    @IBOutlet weak var modeH: UILabel!
    @IBOutlet weak var modeHeight: NSLayoutConstraint!
    @IBOutlet weak var space2: NSLayoutConstraint!
    
    @IBOutlet weak var paymntStatusLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
