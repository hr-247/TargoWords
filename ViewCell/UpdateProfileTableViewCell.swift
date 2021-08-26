//
//  UpdateProfileTableViewCell.swift
//  TolkApp
//
//  Created by sanganan on 6/4/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class UpdateProfileTableViewCell: UITableViewCell {
    
    //outlets
  //  @IBOutlet weak var selLang1: UIButton!
  //  @IBOutlet weak var selLang2: UIButton!
  //  @IBOutlet weak var langCV: UICollectionView!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var changeRoleBtn: UIButton!
    @IBOutlet weak var logOut: UIButton!
    
    @IBOutlet weak var payHistoryBtn: UIButton!
    
    @IBOutlet weak var viewCreditsBtn: UIButton!
   
    //Variables
    var langArr = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
     
        
        
        
 //       langCV.register(UINib(nibName: "RoleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RoleCollectionViewCell")
//        langCV.delegate = self
//        langCV.dataSource = self
    }
    
    
    
    
    
    
    
    
}



