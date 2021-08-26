//
//  ProfileViewController.swift
//  TolkApp
//
//  Created by sanganan on 5/28/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
import FirebaseAuth
import BSImagePicker
import Photos
import SDWebImage
import Mantis

class ProfileViewController: UIViewController, SliderDelegate {
    
    func cellDelegate(moneyValue: Int) {
        
        profileApiData?.perHourRate = moneyValue
        
        priceLbl.text = "€" + "\(moneyValue)" + " \("perHrKey".localizableString(loc: Constant.lang))"
    }
    
    
    func switchToggled(state: Bool)
    {
        profileApiData?.swormIntepretor = state
    }
    
    var toStop = true
    //outlets
    @IBOutlet weak var profileTV: UITableView!
    
    var interPretorLanguages = [UserType]()
    var translaorLanguages = [UserType]()
    //variables
    private var imagePicker = UIImagePickerController()
    private var imageChosen = UIImage()
    var langArr1  = [String]()
    var profileApiData : UserDetail?
    var s3Url: String? = String()
    var priceLbl : UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.profVCT, controller: Constant.Controllers.profile)
        
        Utils.startLoading(self.view)
        
        profileTV.backgroundView = UIImageView(image: UIImage(named: "whitebg"))
        profileTV.register(UINib(nibName: "profileTableViewCell", bundle: nil), forCellReuseIdentifier: "profileTableViewCell")
        profileTV.register(UINib(nibName: "ProfileSliderTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileSliderTableViewCell")
        profileTV.register(UINib(nibName: "UpdateLangProfileTblViewCell", bundle: nil), forCellReuseIdentifier: "UpdateLangProfileTblViewCell")
        profileTV.register(UINib(nibName: "UpdateProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "UpdateProfileTableViewCell")
        profileTV.register(UINib(nibName: "RoleTableCollectionCell", bundle: nil), forCellReuseIdentifier: "RoleTableCollectionCell")
        profileTV.register(UINib(nibName: "TranslatorProfileCell", bundle: nil), forCellReuseIdentifier: "TranslatorProfileCell")
        
        
        profileTV.delegate = self
        profileTV.dataSource = self
        profileTV.estimatedRowHeight = 202
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.profileApi()
    }
    
    public override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        if let capturedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            picker.dismiss(animated: true, completion: nil)
            imageChosen  = capturedImage
            
            self.cropping(capturedImage: imageChosen)
            
        }
    }
    
    func cropping(capturedImage : UIImage)
    {
        let cropViewController = Mantis.cropViewController(image: capturedImage)
        cropViewController.delegate = self
        
        cropViewController.modalPresentationStyle = .fullScreen
        self.present(cropViewController, animated: false)
    }
    
    @IBAction func photoActn(_ sender: UIButton) {
        let btn = UIButton()
        upDocActn(sender: btn)
        
    }
    
    
    @objc func chngRoleActn()
    {
        let vc = Constant.Controllers.role.get() as! RoleViewController
        vc.userData = self.profileApiData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}
extension ProfileViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            if profileApiData?.userType == 1000 || profileApiData?.userType == 1003
            {
                
                return 2
            }
            return 0
            
        }else if section == 2
        {
            if profileApiData?.userType == 1002 || profileApiData?.userType == 1003
            {
                
                return 2
            }
            return 0
            
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileTableViewCell", for: indexPath) as! profileTableViewCell
            
            
            if let url = s3Url
            {
                cell.profileImg.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "user"), options: .continueInBackground, completed: nil)
                
            }else
            {
                cell.profileImg.image =  UIImage(named: "user")
            }
            cell.phoneTF.isUserInteractionEnabled = false
            cell.changeProfileImg.addTarget(self, action: #selector(photoActn), for: .touchUpInside)
            cell.nameTF.text = profileApiData?.name
            cell.nameTF.delegate = self
            cell.emailTF.text = profileApiData?.email
            cell.emailTF.delegate = self
            cell.phoneTF.text = profileApiData?.phone
            cell.phoneTF.delegate = self
            
            let address = "\(profileApiData?.address ?? ""), \(profileApiData?.city ?? ""), \(profileApiData?.state ?? ""), \(profileApiData?.country ?? ""), \(profileApiData?.zip ?? "")"
            
            //  cell.addressTF.text = address
            
            var array = address.components(separatedBy: ",")
            array.removeAll { (str) -> Bool in
                return str.trimWhiteSpaces().count == 0
            }
            
            cell.addressTF.text = array.joined(separator: ",")
            
            cell.addressTF.delegate = self
            return cell
            
        }
        if indexPath.section == 1{
            
            if indexPath.row == 0 {
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSliderTableViewCell", for: indexPath) as! ProfileSliderTableViewCell
                cell.delegate = self
                var str = ""
                if let v = profileApiData?.perHourRate {
                    
                    str = "\(v)"
                    cell.setSliderValue(val : v)
                }
                cell.priceLbl.text  = "€" + str + " \("perHrKey".localizableString(loc: Constant.lang))"
                priceLbl = cell.priceLbl
                cell.swornLbl.text = "swornKey".localizableString(loc: Constant.lang)
                cell.swornSwitch.isOn = profileApiData?.swormIntepretor ?? false
                
                return cell
            }else{
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "RoleTableCollectionCell", for: indexPath) as! RoleTableCollectionCell
                
                cell.isFromProfile = true
                cell.reloadCollection(array : interPretorLanguages)
                
                return cell
                
            }
        }
        else if indexPath.section == 2{
            
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "TranslatorProfileCell", for: indexPath) as! TranslatorProfileCell
                
                let priceTF = cell.viewWithTag(105) as! UITextField
                priceTF.delegate = self
                if let price = profileApiData?.perWordPrice
                {
                    priceTF.text = "\(price)"
                }
                
                return cell
            }else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RoleTableCollectionCell", for: indexPath) as! RoleTableCollectionCell
                
                cell.isFromProfile = true
                cell.reloadCollection(array : translaorLanguages)
                
                return cell
            }
            
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpdateProfileTableViewCell", for: indexPath) as! UpdateProfileTableViewCell
            
            let attrs = [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17.0),
                NSAttributedString.Key.foregroundColor : UIColor.navBarC,
                NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
            
            let attributedString = NSMutableAttributedString(string:"")

            
       //     cell.changeRoleBtn.setTitleColor(UIColor.navBarC, for: .normal)
            cell.logOut.setTitleColor(UIColor.navBarC, for: .normal)
            cell.updateBtn.backgroundColor = UIColor.undrC
            cell.updateBtn.addTarget(self, action: #selector(updateActn), for: .touchUpInside)
            if profileApiData?.userType == 1004 {
             //   cell.changeRoleBtn.setTitle("chngeRoleKey".localizableString(loc: Constant.lang), for: .normal)
                let buttonTitleStr = NSMutableAttributedString(string: "chngeRoleKey".localizableString(loc: Constant.lang), attributes:attrs)
                attributedString.append(buttonTitleStr)
                cell.changeRoleBtn.setAttributedTitle(attributedString, for: .normal)
                
            }else
            {
            //    cell.changeRoleBtn.setTitle("chngRoleLangKey".localizableString(loc: Constant.lang), for: .normal)
                let buttonTitleStr = NSMutableAttributedString(string: "chngRoleLangKey".localizableString(loc: Constant.lang), attributes:attrs)
                attributedString.append(buttonTitleStr)
                cell.changeRoleBtn.setAttributedTitle(attributedString, for: .normal)
            }
            
            cell.changeRoleBtn.addTarget(self, action: #selector(chngRoleActn), for: .touchUpInside)
            cell.logOut.addTarget(self, action: #selector(alertDialog), for: .touchUpInside)
            return cell
        }
        
    }
    
}

extension ProfileViewController: sendDataProtocol
{
    func sendLangBack(language: LangsModal, tag: String) {
        print("do nothing")
    }
    
    func sendDataBack(language: LangsModal) {
        self.dismiss(animated: true)
        // self.langArr1.append(fromLang)
        self.profileTV.reloadData()
    }
    
    //Update Button Action
    @objc func updateActn() {
        
        self.view.endEditing(true)
        
        var email = Bool()
        var name = Bool()
        
        if let em = profileApiData?.email?.trimWhiteSpaces()
        {
          email = isValidEmail(testStr: em)
        }
        
        if let nm = profileApiData?.name?.trimWhiteSpaces()
        {
          name = isValidUsrName(testStr: nm)
        }
        
        if email == true && name == true {
            
            self.updateProfileApi()
        }
        else if profileApiData?.email?.trimWhiteSpaces() == "" || profileApiData?.name?.trimWhiteSpaces() == "" {
            
            AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
        }
        else if name == false {
            
            AppUtils.showToast(message: Constant.Msg.invalNmeMsg)
        }
        else if email == false {
            
            AppUtils.showToast(message: Constant.Msg.invalEmlMsg)
        }
        
    }
    
    //MARK:- Profile Post Api
    func profileApi()
    {
        
        let url:String = "\(Constant.APIs.baseURL)/profile"
        guard let uId = AppUtils.getStringForKey(key: Constant.userData.id) else { return }
        let request:[String:Any] = ["userId": uId]
        
        Service.sharedInstance.postRequest(Url:url,modalName: ProfileModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                if self.toStop == true
                {
                    self.toStop = false
                    Utils.stopLoading()
                }
                if let res = response?.Success{
                    if res == 1{
                        
                        let card = response?.paymentDetail
                        
                        if card!.count > 0
                        {
                            AppUtils.setStringForKey(key: Constant.userData.creditCardVal, val: "1")
                        }else
                        {
                            AppUtils.setStringForKey(key: Constant.userData.creditCardVal, val: "0")
                        }
                        
                        
                        
                        self.profileApiData = response?.userDetail
                        self.s3Url = response?.userDetail?.profilePic
                        self.setDataFromProfile()
                        self.profileTV.reloadData()
                    }
                    else {
                        
                        
                    }
                    
                }
            }}
        
    }
    func setDataFromProfile()
    {
        if let userType  = profileApiData?.userType
        {
            
            interPretorLanguages.removeAll()
            translaorLanguages.removeAll()
            if userType == 1000 || userType == 1002 || userType == 1003{
                if let languages = profileApiData?.langauges
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
    
    //MARK:- Update Profile Api
    func updateProfileApi()
    {
        
        Utils.startLoading(self.view)
        var perHourRate : Int = 0
        
        if let rate = profileApiData?.perHourRate
        {
            perHourRate = rate
        }
        var perWordPrice = 0.0
        if let perWord = self.profileApiData?.perWordPrice
        {
            perWordPrice = Double(perWord)
        }
        
        
        var name = String()
        if let str = self.profileApiData?.name?.trimmingCharacters(in: .whitespacesAndNewlines) {
            
            name = str
        }
        
        var email = ""
        if let mail = self.profileApiData?.email
        {
            email = mail
        }
        
        
        var sworn = false
        if let swornTI = self.profileApiData?.swormIntepretor
               {
                   sworn = swornTI
               }
        
        let url:String = "\(Constant.APIs.baseURL)/updateprofile"
        guard let uId = AppUtils.getStringForKey(key: Constant.userData.id) else { return }
        let request:[String:Any] = ["pass": "", "lowestPrice": 75, "highestPrice": 92, "perHourRate": perHourRate, "name": name, "userId": uId, "profilePic": self.s3Url!, "perWordPrice":perWordPrice,"email":email, "swormIntepretor":sworn]
        
        Service.sharedInstance.postRequest(Url:url,modalName: UpdateProfileModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.success{
                    
                    SDImageCache.shared().removeImage(forKey: self.s3Url) {
                        
                    }
                    
                    if res == 1{
                        
                        //  self.profileTV.reloadData()
                        self.profileApi()
                        AppUtils.showToast(message: "profileUpdatedKey".localizableString(loc: Constant.lang))
                    }
                    else {
                        
                        AppUtils.showToast(message: (response?.message)!)
                    }
                }
            }}
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 101 {
            
            self.profileApiData?.name = textField.text
        }
        else if textField.tag == 102 {
            
            self.profileApiData?.phone = textField.text
        }
        else if textField.tag == 103 {
            
            self.profileApiData?.email = textField.text
        }
        else if textField.tag == 104 {
            
            self.profileApiData?.address = textField.text
        }else if textField.tag == 105 {
            
            self.profileApiData?.perWordPrice = (textField.text! as NSString).floatValue
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.tag == 104 {
            
            let vc = Constant.Controllers.addr.get() as! AddressViewController
            vc.pushFrmProfile = true
            vc.pushdModal = profileApiData
            self.navigationController?.pushViewController(vc, animated: true)
            return false
        }
        else {
            
            return true
        }
        
    }
    
}


extension ProfileViewController : CropViewControllerDelegate
{
    public func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
        
        uploadImageToAWS(cropped) { (urlStr, error) in
            
            if let url = urlStr
            {
                
                self.s3Url = url
            }
            self.profileTV.reloadData()
        }
        cropViewController .dismiss(animated: true, completion: nil)
    }
    
    public func cropViewControllerDidFailToCrop(_ cropViewController: CropViewController, original: UIImage) {
        //  croppingHandler(nil,nil)
        cropViewController .dismiss(animated: true, completion: nil)
    }
    
    public func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage){
        //   croppingHandler(nil,nil)
        cropViewController .dismiss(animated: true, completion: nil)
    }
    
    public func cropViewControllerWillDismiss(_ cropViewController: CropViewController) {
        
    }
}
