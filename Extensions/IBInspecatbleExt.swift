//
//  IBInspecatbleExt.swift
//  SPP
//
//  Created by sanganan on 1/15/20.
//  Copyright © 2020 Sanganan. All rights reserved.
//

import UIKit
extension UIView{
    @IBInspectable var roundCorner : CGFloat{
        get {
            return self.frame.width/2
        }
        set{
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable var borderWidth : CGFloat{
        get {
            return self.frame.width
        }
        set{
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor : UIColor{
        get {
            return self.borderColor
        }
        set{
            layer.borderColor = newValue.cgColor
        }
    }
}

extension UITextField {
    @IBInspectable var cornerRadius: CGFloat {
        set{
            layer.cornerRadius = newValue
        }
        get{
            return layer.cornerRadius
        }
    }
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    //MARK:- Set Left Padding of TextField
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
}

