//
//  SelectLangViewController.swift
//  TolkApp
//
//  Created by sanganan on 6/2/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

protocol sendDataProtocol {
    func sendDataBack(language: LangsModal)
    func sendLangBack(language: LangsModal,tag: String)
}

class SelectLangViewController: UIViewController{
    
    @IBOutlet weak var selLangTV: UITableView!
    
    @IBOutlet weak var searchTF: UITextField!
    
//    @IBOutlet weak var bgView: UIImageView!
    
    
    //variables
    var delegate : sendDataProtocol?
    var whchBtn : Int = Int()
    var languages = [LangsModal]()
    var searchedLanguages = [LangsModal]()
    var selectedLanguage : LangsModal?
    var identity : String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.langVCT, controller: Constant.Controllers.selLang)
    
        searchTF.cornerRadius = 20.0
        searchTF.borderWidth = 2.0
        searchTF.borderColor = UIColor.undrC
        searchTF.setLeftPaddingPoints(35)
        
        selLangTV.register(UINib(nibName: "SelLangTableViewCell", bundle: nil), forCellReuseIdentifier: "SelLangTableViewCell")
        self.selLangTV.tableFooterView = UIView(frame: .zero)
        self.getLangaugeFromServer()
        
        selLangTV.dataSource = self
        selLangTV.delegate = self
        
        for str in languages
        {
            searchedLanguages.append(str)
        }
        
        
        searchTF.delegate = self
    }
    
    override func backBtn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getLangaugeFromServer()
    {
        Utils.startLoading(self.view)
        Service.sharedInstance.getRequest(Url: Constant.APIs.getLanguages, modalName: LanguagesModal.self) { (result, error) in
            Utils.stopLoading()
            guard let json = result else {return}
            
            if json.Success! == 1
            {
                self.languages = json.language!
                self.searchedLanguages = self.languages
            }
            
            
            self.selLangTV.reloadData()
            
        }
    }
    
    
}
extension SelectLangViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelLangTableViewCell", for: indexPath) as! SelLangTableViewCell
        cell.contentView.isHidden = false
        if selectedLanguage?._id == searchedLanguages[indexPath.row]._id
        {
            cell.contentView.isHidden = true
            return cell
        }
        if let language = searchedLanguages[indexPath.row].language
        {
            cell.langLbl.text = language
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.sendDataBack(language: searchedLanguages[indexPath.row])
        self.delegate?.sendLangBack(language: searchedLanguages[indexPath.row], tag: identity)
        dismiss(animated: true, completion: nil)
  
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedLanguage?._id == searchedLanguages[indexPath.row]._id
        {
            return 0
        }
        
        return UITableView.automaticDimension
    }
    
}
//MARK: UITextFieldDelegtaes
extension SelectLangViewController
{
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.searchTF.resignFirstResponder()
        self.searchTF.text = ""
        self.searchedLanguages.removeAll()
        for str in languages
        {
            searchedLanguages.append(str)
        }
        self.selLangTV.reloadData()
        return false
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString:NSString = textField.text! as NSString
                   let newString:NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        if newString.length == 0
        {
            self.searchedLanguages.removeAll()
            self.searchedLanguages = self.languages
            self.selLangTV.reloadData()

            return true

        }
  
        self.searchedLanguages = self.languages.filter({ (lang) -> Bool in
            return (lang.language?.lowercased().range(of: newString as! String, options: .caseInsensitive, range: nil, locale: nil)) != nil
        })
        
        self.selLangTV.reloadData()

        return true
    }
    
    
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if searchTF.text?.count != 0 {
//            self.searchedLanguages.removeAll()
//            for data in languages{
//                let str = data.language
//                let range = str!.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
//                if range != nil
//                {
//                    self.searchedLanguages.append(data)
//                }
//            }
//        }
//        self.selLangTV.reloadData()
        textField.resignFirstResponder()
        return true
    }
}
