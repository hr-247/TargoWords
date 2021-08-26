//
//  profileTableViewCell.swift
//  TolkApp
//
//  Created by sanganan on 6/4/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class profileTableViewCell: UITableViewCell {
    
    //outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var changeProfileImg: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        phoneTF.setLeftPaddingPoints(50)
        nameTF.setLeftPaddingPoints(50)
        emailTF.setLeftPaddingPoints(50)
        addressTF.setLeftPaddingPoints(50)
        phoneTF.setUnderLine()
        nameTF.setUnderLine()
        emailTF.setUnderLine()
        addressTF.setUnderLine()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
