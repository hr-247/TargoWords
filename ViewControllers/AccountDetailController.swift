 //
//  AccountDetailController.swift
//  TolkApp
//
//  Created by sanganan on 7/16/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class AccountDetailController: UIViewController {
    
    //Variables
    var accountDetails = AccountModal()
    
    //Outlets
    @IBOutlet weak var swiftNumberTF: UITextField!
    @IBOutlet weak var taxIdTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var bankAccountTF: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.accountVCT, controller: Constant.Controllers.account)
        addBtn.backgroundColor = UIColor.undrC
        
        swiftNumberTF.placeholder = Constant.Placeholder.swiftNoTxt
        taxIdTF.placeholder = Constant.Placeholder.taxIDTxt
        nameTF.placeholder = Constant.Placeholder.accountHolderTxt
        bankAccountTF.placeholder = Constant.Placeholder.bnkAccountTxt
        addBtn.setTitle(Constant.Placeholder.saveTxt, for: .normal)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getBankAccountApi()
    }
    
    @IBAction func addActn(_ sender: Any) {
        self.view.endEditing(true)
        
        let name = isValidUsrName(testStr: nameTF.text!)
        
        if name == true && swiftNumberTF.text?.trimWhiteSpaces() != "" && taxIdTF.text?.trimWhiteSpaces() != "" && bankAccountTF.text?.trimWhiteSpaces() != ""{
            
            addBankAccountApi()
        }
        else if nameTF.text?.trimWhiteSpaces() == "" || swiftNumberTF.text?.trimWhiteSpaces() == "" || taxIdTF.text?.trimWhiteSpaces() == "" || bankAccountTF.text?.trimWhiteSpaces() == "" {
            
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
        }
        
    }
    
}
extension AccountDetailController
{
    //Add Bank Account Post Api
    func addBankAccountApi()
    {
        let name = nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Utils.startLoading(self.view)
        let request:[String:Any] = ["userId" : Constant.appDel.userId,
                                    "accountNumber" : bankAccountTF.text!,
                                    "name": name!,
                                    "swiftNumber": swiftNumberTF.text!,
                                    "taxId": taxIdTF.text!
        ]
        Service.sharedInstance.postRequest(Url:Constant.APIs.updateAccountDetails,modalName: approvedDocModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"bankAccountAdd"), object: nil)
                        self.navigationController?.popViewController(animated: true)
                        
                        AppUtils.showToast(message: Constant.Msg.bnkAddedMsg)
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                }
            }
            
        }
        
    }
    
    //get Bank Account details Post Api
    func getBankAccountApi()
    {
  
        Utils.startLoading(self.view)
        let request:[String:Any] = ["userId" : Constant.appDel.userId]
        Service.sharedInstance.postRequest(Url:Constant.APIs.getAccountDetails,modalName: GetBankDetaills.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        self.swiftNumberTF.text = response?.data?.swiftNumber
                        self.taxIdTF.text = response?.data?.taxId
                        self.nameTF.text = response?.data?.name
                        self.bankAccountTF.text = response?.data?.accountNumber
                    }else{
                 //       AppUtils.showToast(message: (response?.Message)!)
                    }
                }
            }
            
        }
        
    }
}
//MARK :- Textfield Check
extension AccountDetailController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        if textField == self.bankAccountTF {
            
            let maxLength = 16
            let currentString:NSString = textField.text! as NSString
            let newString:NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            if allowedCharacters.isSuperset(of: characterSet) == false
            {
                
                return false
            }
            // code for paste and limiting them
            if (newString.length > maxLength){
                let mySubstring = String(newString).prefix(maxLength)
                textField.text = String(mySubstring)
            }
            // end
            return newString.length <= maxLength
            
        }
        
        return true
    }
    
}
