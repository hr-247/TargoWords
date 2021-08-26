//
//  HomeTableViewCell.swift
//  TolkApp
//
//  Created by sanganan on 5/28/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var durLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var langLbl: UILabel!
    
    @IBOutlet weak var addrLbl: UILabel!
    
    @IBOutlet weak var durationLbl: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var jobNo: UILabel!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var cancelledLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cancelledLbl.backgroundColor = UIColor.navBarC
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
