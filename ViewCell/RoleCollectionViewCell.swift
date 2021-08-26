//
//  RoleCollectionViewCell.swift
//  TolkApp
//
//  Created by sanganan on 5/26/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class RoleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var lngLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.backgroundColor = UIColor.navBarC
    }

}
