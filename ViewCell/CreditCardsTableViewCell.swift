//
//  CreditCardsTableViewCell.swift
//  TolkApp
//
//  Created by sanganan on 7/2/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class CreditCardsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bankNameLbl: UILabel!
   // @IBOutlet weak var accHolderNmeLbl: UILabel!
    @IBOutlet weak var cardExpiryLbl: UILabel!
    
    @IBOutlet weak var removeBtn: UIButton!
    
    
    @IBOutlet weak var defaultCrdLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultCrdLbl.backgroundColor = UIColor.navBarC
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
