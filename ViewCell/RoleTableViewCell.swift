//
//  RoleTableViewCell.swift
//  TolkApp
//
//  Created by sanganan on 5/26/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

protocol RoleCellDelegate {
    func fromLanguageBtnTapped(_ sender : RoleTableViewCell)
     func toLanguageBtnTapped(_ sender : RoleTableViewCell)
 }
class RoleTableViewCell: UITableViewCell {
    
 
    //Outlets
    @IBOutlet weak var fromLngVw: UIView!
    @IBOutlet weak var toLangVw: UIView!
    @IBOutlet weak var fromLangLbl: UILabel!
    @IBOutlet weak var toLangLbl: UILabel!
    @IBOutlet weak var selLangBtn2: UIButton!
    @IBOutlet weak var selLangBtn: UIButton!
    var delegate : RoleCellDelegate?
    
    //Variables
    var langArr = [String]()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

       
    }
   
    
    //MARK:  UIButtonAction
    @IBAction func fromLanguageClicked(_ sender: Any) {
        self.delegate?.fromLanguageBtnTapped(self)
    }
    @IBAction func toLanguageClicked(_ sender: Any) {
        self.delegate?.toLanguageBtnTapped(self)
    }
}
