//
//  RoleViewController.swift
//  TolkApp
//
//  Created by sanganan on 5/22/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit


class UserType: NSObject {
    
    var userRole : Int?
    var sourceLanguage : LangsModal?
    var destinationLanguage : LangsModal?
    
    
    override init() {
        // self.userRole = [String : Any]()
        userRole = nil
        self.sourceLanguage = nil
        self.destinationLanguage = nil
    }
    
    init(role : Int?, source : LangsModal?, destination : LangsModal? ) {
        userRole = role
        self.sourceLanguage = source
        self.destinationLanguage = destination
    }
    
}

class RoleViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var roleTV: UITableView!
    @IBOutlet weak var registringLbl: UILabel!
    
    var changeObserved = false

    //variables
    var selectedIndx = 3
    var interPretorLanguages = [UserType]()
    var translaorLanguages = [UserType]()
    var tempInterPretorType = UserType()
    var tempTranslatorType = UserType()
    
    var userData : UserDetail?
    
    var languageType = 0 // 1 - interpretor source, 2 - interpretor destination, 3 - Translator source, 4 - Translator destination
  
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setDataFromProfile()
        
        commonNavigationBar(title: Constant.navTitles.roleVCT, controller: Constant.Controllers.role)
        
        registringLbl.text = "registeringKey".localizableString(loc: Constant.lang)
        
        roleTV.register(UINib(nibName: "MyCustomHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "MyCustomHeaderCell")
        roleTV.register(UINib(nibName: "RoleTableViewCell", bundle: nil), forCellReuseIdentifier: "RoleTableViewCell")
        roleTV.register(UINib(nibName: "RoleTableCollectionCell", bundle: nil), forCellReuseIdentifier: "RoleTableCollectionCell")
        roleTV.delegate = self
        roleTV.dataSource = self
        roleTV.isScrollEnabled = false
        
    }
    
    
    override func backBtn() {
        if changeObserved == false {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func setDataFromProfile()
    {
        if let userType  = userData?.userType
        {
            
            let index = classConst.rolesArr.lastIndex { (role) -> Bool in
                return role["id"] as! Int == userType
            }
            if index != nil{                  //app crashing
                selectedIndx = index!
            }
            
            if userType == 1000 || userType == 1002 || userType == 1003{
                if let languages = userData?.langauges
                {
                    
                    for item in languages
                    {
                        if item.type == 1000 {
                            interPretorLanguages.append(UserType(role: item.type, source: item.fromLanguage, destination: item.toLanguage))
                            
                        }else if item.type == 1002
                        {
                            translaorLanguages.append(UserType(role: item.type, source: item.fromLanguage, destination: item.toLanguage))
                        }
                        
                    }
                    
                }
            }
            
            
        }
    }
    
    func removeInterpreterData()
    {
        tempInterPretorType = UserType()
        interPretorLanguages.removeAll()
    }
    func removeTranslatorData()
    {
        tempTranslatorType = UserType()
        translaorLanguages.removeAll()
        
    }
    
    
    @IBAction func nextBtn(_ sender: Any) {
        
        if selectedIndx == 3 {
            
            self.setUserAsJobCreator()
            
            
            return
        }else if selectedIndx == 0
        {
            if interPretorLanguages.count == 0 {
                AppUtils.showToast(message: Constant.Msg.langErr)
                return
            }
            
            self.userTypeLngApi(data: interPretorLanguages)
        }else if selectedIndx == 1
        {
            if translaorLanguages.count == 0 {
                AppUtils.showToast(message: Constant.Msg.langErr)
                return
            }
            self.userTypeLngApi(data: translaorLanguages)
            
        }else if selectedIndx == 2
        {
            if translaorLanguages.count == 0 || interPretorLanguages.count == 0 {
                AppUtils.showToast(message: Constant.Msg.langErr)
                return
            }
            self.userTypeLngApi(data: interPretorLanguages + translaorLanguages)
        }
        
    }
    
    @objc func whSection(sender: UIButton)
    {
        if selectedIndx == sender.tag {
            return
        }
        
        if sender.tag == 0 {
            // interpreter select
            self.removeInterpreterData()
            
        }else if sender.tag == 1 {
            // translator select
            self.removeTranslatorData()
            
        }else if sender.tag == 2
        {
            // both select
            self.removeInterpreterData()
            self.removeTranslatorData()
        }
        selectedIndx = sender.tag
        roleTV.reloadData()
    }
    
    @objc func addBtnAction(_ sender: UIButton)
    {
        if sender.tag == 0 {
            // interpreter add
            if let _ = tempInterPretorType.sourceLanguage, let _ = tempInterPretorType.destinationLanguage
            {
                interPretorLanguages.append(tempInterPretorType)
                tempInterPretorType = UserType()
                
            }else
            {
                AppUtils.showToast(message: Constant.Msg.langErr)
            }
            
        }else if sender.tag == 1
        {
            // translator option
            if let _ = tempTranslatorType.sourceLanguage, let _ = tempTranslatorType.destinationLanguage
            {
                translaorLanguages.append(tempTranslatorType)
                tempTranslatorType = UserType()
                
            }else
            {
                AppUtils.showToast(message: Constant.Msg.langErr)
            }
        }
        roleTV.reloadData()
    }
    @objc func handleTapGesture(gesture : UITapGestureRecognizer)
    {
        let v = gesture.view!
        let btn = UIButton()
         btn.tag = v.tag
        whSection(sender: btn)
    }

}
extension RoleViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return classConst.rolesArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if section == 0 {
            if selectedIndx == 0 || selectedIndx == 2 {
                if interPretorLanguages.count > 0
                {
                    return 2
                }else{
                    return 1
                }
                
            }
        }
        if section == 1 {
            if selectedIndx == 1 || selectedIndx == 2 {
                if translaorLanguages.count > 0
                {
                    return 2
                }else{
                    return 1
                }
            }
        }
        return 0
        
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyCustomHeaderCell") as! MyCustomHeaderCell
    
        let dict = classConst.rolesArr[section]
        vw.titleLbl.text = (dict["type"] as! String)
        vw.radioBtn.tag = section
        vw.radioBtn.addTarget(self, action: #selector(whSection), for: .touchUpInside)
        vw.tag = section
        vw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
        self.view.addSubview(vw)
        if section == selectedIndx{
            
            vw.radioBtn.isSelected = true
            vw.addBtn.isHidden = true
            
        }else{
            vw.radioBtn.isSelected = false
            vw.addBtn.isHidden = true
        }
        if (section == 0 || section == 1) && selectedIndx == 2 {
            vw.radioBtn.isSelected = true
            vw.addBtn.isHidden = true
        }
        
        if section == 2 || section == 3
        {
            vw.addBtn.isHidden = true
        }
        vw.addBtn.tag = section
        vw.addBtn.addTarget(self, action: #selector(addBtnAction(_:) ), for: .touchUpInside)
        
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoleTableViewCell", for: indexPath) as! RoleTableViewCell
            
            cell.tag = indexPath.section
            cell.delegate = self
            
            if indexPath.section == 0
            {
                cell.fromLangLbl.text = Constant.vcTitles.selectlang
                cell.toLangLbl.text = Constant.vcTitles.selcttoLng
                
                if let lang = tempInterPretorType.sourceLanguage?.language
                {
                    cell.fromLangLbl.text = lang
                }
                if let lang = tempInterPretorType.destinationLanguage?.language
                {
                    cell.toLangLbl.text = lang
                }
            }
            if indexPath.section == 1
            {
                cell.fromLangLbl.text = Constant.vcTitles.selctFrmLng
                cell.toLangLbl.text = Constant.vcTitles.selcttoLng
                if let lang = tempTranslatorType.sourceLanguage?.language
                {
                    cell.fromLangLbl.text = lang
                }
                if let lang = tempTranslatorType.destinationLanguage?.language
                {
                    cell.toLangLbl.text = lang
                }
            }
            
            return cell
            
        }else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoleTableCollectionCell", for: indexPath) as! RoleTableCollectionCell
            cell.delegate = self
            cell.langCollctnVw.tag = indexPath.section
            if indexPath.section == 0
            {
                //cell.userArr = interPretorLanguages
                cell.reloadCollection(array : interPretorLanguages)
                
            }else
            {
                //cell.userArr = translaorLanguages
                cell.reloadCollection(array : translaorLanguages)
            }
            
            
            return cell
            
        }
        
        //cell.langArr = selLangArr
        
    }
    
    func languageAction()
    {
        let vc = Constant.Controllers.selLang.get() as! SelectLangViewController
        //  vc.whchBtn = sender.tag
        vc.delegate = self
        if languageType == 2 {
            
            vc.selectedLanguage = tempInterPretorType.sourceLanguage
        }else if languageType == 4
        {
            vc.selectedLanguage = tempTranslatorType.sourceLanguage
        }
        
        let nav = UINavigationController(rootViewController: vc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
}


extension RoleViewController : RoleCollectionDelegate
{
    func removeLanguageAt(index: Int, fromSection sec: Int)
    {
        if sec == 0 {
            interPretorLanguages.remove(at: index)
            
        }else if sec == 1
        {
            translaorLanguages.remove(at: index)
        }
        self.roleTV.reloadData()
    }
}

extension RoleViewController : RoleCellDelegate
{
    func fromLanguageBtnTapped(_ sender : RoleTableViewCell)
    {
        if sender.tag == 0 {
            
            languageType = 1
        }else
        {
            languageType = 3
        }
        self.languageAction()
        
    }
    func toLanguageBtnTapped(_ sender : RoleTableViewCell)
    {
        if sender.tag == 0 {
            
            if tempInterPretorType.sourceLanguage == nil {
                
                AppUtils.showToast(message: "Please choose source language first.")
                return
            }
            
            languageType = 2
        }else
        {
            if tempTranslatorType.sourceLanguage == nil {
                
                AppUtils.showToast(message: "Please choose source language first.")
                return
            }
            languageType = 4
        }
        self.languageAction()
        
    }
    
    
    
    
}

extension RoleViewController
{
    
 
    func setUserAsJobCreator()
    {
        
        Utils.startLoading(self.view)
        let url:String = "\(Constant.APIs.baseURL)/updateuserasjobcreater"
        
        let param : [String : Any] = ["userId":Constant.appDel.userId]
        
        
        Service.sharedInstance.postRequest(Url:url,modalName: userTypeLangModal.self , parameter: param as [String:Any]) { (response, error) in
            Utils.stopLoading()
            if let res = response?.Success{
                if res == 1{
                    
                    AppUtils.setStringForKey(key: Constant.userData.userType!, val: "\(1004)")
                    if  self.userData?.userType == 1004 {
                                               
                      self.navigationController?.popViewController(animated: true)
                    }else{
                                           
                    let vc = Constant.Controllers.home.get() as! HomeViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                    if  self.userData?.userType == nil {
                    AppUtils.showToast(message: "User created successfully.")
                    
                    }
                 }
                }else{
                    AppUtils.showToast(message: (response?.Message)!)
                }
            }
    }
    }
    
    //User Type and language Post Api
    func userTypeLngApi(data : [UserType])
    {
        
        Utils.startLoading(self.view)
        let url:String = "\(Constant.APIs.baseURL)/insertusertypeandlanguage"
        
        
        
        var request:[[String:Any]] = [[String:Any]]()
        
        let userRole = classConst.rolesArr[selectedIndx]["id"] as! Int
        for type in data
        {
            let singleReq:[String:Any] = [
                "type": type.userRole!,
                "user": Constant.appDel.userId,
                "fromLanguage": type.sourceLanguage!._id!,
                "toLanguage": type.destinationLanguage!._id!
            ]
            request.append(singleReq)
        }
        
        let param : [String : Any] = ["userRole":userRole, "language":request]
        
        
        Service.sharedInstance.postRequest(Url:url,modalName: userTypeLangModal.self , parameter: param as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                         AppUtils.setStringForKey(key: Constant.userData.userType!, val: String(describing: userRole))
                        if userRole == self.userData?.userType {
                            
                           // role not changed. now need to check whether languages has been changed or not
                            var prevLang = [String]()
                            var selLang = [String]()
                            if let language = self.userData?.langauges
                            {
                                for lang in language
                                {
                                    prevLang.append(lang.fromLanguage!._id! + "-" + lang.toLanguage!._id!)
                                }
                            }
                            
                            for type in data
                            {
                                selLang.append(type.sourceLanguage!._id! + "-" + type.destinationLanguage!._id!)

                            }
                            if prevLang.count == selLang.count {
                                
                                for item in selLang
                                {
                                    if prevLang.contains(item) == false {
                                        self.changeObserved = true
                                        break;
                                    }
                                    
                                }
                            }else
                            {
                                self.changeObserved = true

                            }
                            
                            if self.changeObserved == true
                            {
                                let vc = Constant.Controllers.upDoc.get() as! UploadDocViewController
                                vc.userData = self.userData
                                vc.pageCheck = true
                                self.navigationController?.pushViewController(vc, animated: true)
                                return
                            }
                            
                            self.navigationController?.popViewController(animated: true)
                        }else{
                        
                        let vc = Constant.Controllers.upDoc.get() as! UploadDocViewController
                        vc.userData = self.userData
                        self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                }
            }
        }
        
    }
    
}


extension RoleViewController: sendDataProtocol
{
    func sendLangBack(language: LangsModal, tag: String) {
        print("")
    }
    
    func sendDataBack(language: LangsModal){
        //self.selLangArr.append(fromLang)
        
        
        switch languageType {
        case 1:
            tempInterPretorType.userRole  =  classConst.rolesArr[0]["id"] as? Int
            tempInterPretorType.sourceLanguage = language
            self.roleTV.reloadData()
        case 2:
            tempInterPretorType.userRole  =  classConst.rolesArr[0]["id"] as? Int
            tempInterPretorType.destinationLanguage = language
            let btn = UIButton()
            btn.tag = 0
            self.addBtnAction(btn)
            
        case 3:
            tempTranslatorType.userRole   =  classConst.rolesArr[1]["id"] as? Int
            tempTranslatorType.sourceLanguage = language
            self.roleTV.reloadData()
            
        case 4:
            tempTranslatorType.userRole   =  classConst.rolesArr[1]["id"] as? Int
            tempTranslatorType.destinationLanguage = language
            let btn = UIButton()
            btn.tag = 1
            self.addBtnAction(btn)
            
        default:
            print("No case found")
        }
        
    }
    
    
}
