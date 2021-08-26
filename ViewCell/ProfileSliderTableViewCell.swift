//
//  ProfileSliderTableViewCell.swift
//  TolkApp
//
//  Created by sanganan on 6/4/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
import RangeSeekSlider

//protocol ProfileDelegate {
//
//    func docRemoved (doc : Int)
//}

protocol SliderDelegate : class
{
    func cellDelegate(moneyValue: Int) -> Void
    func switchToggled(state: Bool) -> Void

    
}

class ProfileSliderTableViewCell: UITableViewCell,RangeSeekSliderDelegate {
    
    @IBOutlet weak var rightLbl: UILabel!
    @IBOutlet weak var leftLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    var delegate : SliderDelegate?
    var moneyValue: Int = Int()
    var moneyAmount: String = String()
    
    @IBOutlet weak var swornLbl: UILabel!
    @IBOutlet weak var swornSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        priceLbl.backgroundColor = UIColor.navBarC
        

    }
    
    
    func setSliderValue(val : Int)
    {
        
        slider.minimumValue = 75.0
        slider.maximumValue = 92.0
        slider.value = Float(val)

        self.leftLbl.text = "€ 75"
        self.rightLbl.text = "€ 92"

   
    }
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {

     //   priceLbl.text = "€" + "\(Int(minValue))" + " per hour"

        delegate?.cellDelegate(moneyValue: Int(minValue))

    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        
        let slid = sender as! UISlider
        moneyValue = Int(slid.value)
               priceLbl.text = String(moneyValue)
               moneyAmount = priceLbl.text!

                   delegate?.cellDelegate(moneyValue: moneyValue)
        
    }
    
    @IBAction func switchToggled(_ sender: Any) {
        
        
        let switchTI = sender as! UISwitch
        
        self.delegate?.switchToggled(state: switchTI.isOn)
        
    }
    
    @IBAction func currencySliderActon(_ sender: UISlider) {
        
        
        
        
        moneyValue = Int(sender.value)
        priceLbl.text = String(moneyValue)
        moneyAmount = priceLbl.text!

            delegate?.cellDelegate(moneyValue: moneyValue)
        
        
    }
}
