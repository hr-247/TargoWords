//
//  TranslatorDocViewController.swift
//  TolkApp
//
//  Created by sanganan on 7/22/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
import Mantis

class TranslatorDocViewController: UIViewController {
    
    //Variables
    var imagesArr = [uploadDocuments]()
    var userType = ""
    var tiId = ""
    var jobCreaterId = ""
    var jobId = ""
    var pagesNo = ""
    var wordsNo = ""
    var translatedDoc = [uploadDocModal]()
    var jbCreaterPagesNo = ""
    var jbCreaterWordsNo = ""
    var jbCreatertranslatedDoc = [uploadDocModal]()
    
    @IBOutlet weak var translatorDocCV: UICollectionView!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var nxtBtn: UIButton!
    @IBOutlet weak var pagesTF: UITextField!
    @IBOutlet weak var wordsTF: UITextField!
    @IBOutlet weak var beforeCompletionHeadng: UILabel!
    @IBOutlet weak var jbCreaterPagesTF: UITextField!
    @IBOutlet weak var jbCreaterWordsTF: UITextField!
    @IBOutlet weak var jbCreaterCollectnView: UICollectionView!
    @IBOutlet weak var afterJbCompltnHeadngLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uType = AppUtils.getStringForKey(key: Constant.userData.userType!)
        {
            self.userType = uType
        }
        var navTitle = ""
        
        if self.userType == "1004"
        {
            
            navTitle = Constant.navTitles.uploadedVCT
            headingLbl.text = "transUploadedKey".localizableString(loc: Constant.lang)
            wordsTF.isUserInteractionEnabled = false
            pagesTF.isUserInteractionEnabled = false
        }else{
            
            navTitle = Constant.navTitles.upDocVCT
            headingLbl.text = "transUploadKey".localizableString(loc: Constant.lang)
        }
        commonNavigationBar(title: navTitle, controller: Constant.Controllers.translatorDoc)
        
        beforeCompletionHeadng.text = "docToBTransKey".localizableString(loc: Constant.lang)
        
        jbCreaterPagesTF.keyboardType = .numberPad
        jbCreaterWordsTF.keyboardType = .numberPad
        jbCreaterPagesTF.placeholder = "pagesNoKey".localizableString(loc: Constant.lang)
        jbCreaterWordsTF.placeholder = "wordsNoKey".localizableString(loc: Constant.lang)
        jbCreaterPagesTF.text = String(describing: jbCreaterPagesNo)
        jbCreaterWordsTF.text = String(describing: jbCreaterWordsNo)
        jbCreaterPagesTF.isUserInteractionEnabled = false
        jbCreaterWordsTF.isUserInteractionEnabled = false
        
        pagesTF.keyboardType = .numberPad
        wordsTF.keyboardType = .numberPad
        pagesTF.placeholder = "pagesNoKey".localizableString(loc: Constant.lang)
        wordsTF.placeholder = "wordsNoKey".localizableString(loc: Constant.lang)
        pagesTF.text = String(describing: pagesNo)
        wordsTF.text = String(describing: wordsNo)
        
        afterJbCompltnHeadngLbl.isHidden = true
        afterJbCompltnHeadngLbl.text = "afterJbCompltnKey".localizableString(loc: Constant.lang)
        
        translatorDocCV.register(UINib(nibName:"AddDocCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddDocCollectionViewCell")
        translatorDocCV.register(UINib(nibName:"DocsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DocsCollectionViewCell")
        translatorDocCV.delegate = self
        translatorDocCV.dataSource = self
        jbCreaterCollectnView.register(UINib(nibName:"AddDocCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddDocCollectionViewCell")
        jbCreaterCollectnView.register(UINib(nibName:"DocsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DocsCollectionViewCell")
        jbCreaterCollectnView.delegate = self
        jbCreaterCollectnView.dataSource = self
        pagesTF.delegate = self
        wordsTF.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
    
            if self.userType == "1004" {
                
                self.nxtBtn.isHidden = true
            }else
            {
                self.nxtBtn.isHidden = false
            }
        reloadCollection()
        }
        
    
    public override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        if let capturedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            picker.dismiss(animated: true) {
                self.cropping(capturedImage: capturedImage)
            }
        }
    }
    
    func cropping(capturedImage : UIImage)
    {
        let cropViewController = Mantis.cropViewController(image: capturedImage)
        cropViewController.delegate = self
        cropViewController.modalPresentationStyle = .fullScreen
        self.present(cropViewController, animated: false)
    }
    
    @objc func removedClicked(sender : UIButton)
    {
        self.docRemoved(doc: self.imagesArr[sender.tag])
    }
    func docRemoved(doc: uploadDocuments)
    {
        imagesArr.removeAll { (document) -> Bool in
                   return document == doc
               }
        reloadCollection()
    }
    
    @IBAction func nxtActn(_ sender: UIButton) {
        
        
        if imagesArr.count == 0 {
            
            AppUtils.showToast(message: Constant.Msg.docErrMsg)
            return
        }
        else if pagesTF.text == "" || wordsTF.text == ""
        {
           AppUtils.showToast(message: Constant.Msg.allFldsManMsg)
            return
        }
        else if pagesTF.text == "0"
        {
            AppUtils.showToast(message: "pageGreterThan0Key".localizableString(loc: Constant.lang))
            return
        }
        else if wordsTF.text == "0"
        {
           AppUtils.showToast(message: "wordGreterThan0Key".localizableString(loc: Constant.lang))
            return
        }
        
        self.uploadTransDocApi()
    }
    
    
}
extension TranslatorDocViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == jbCreaterCollectnView
        {
            if section == 0
            {
                return jbCreatertranslatedDoc.count
            }else{
                return 0
            }
        }else{
    
        if section == 0
        {
            if self.userType == "1004"
            {
                return translatedDoc.count
                
            }else{
                return imagesArr.count
            }
            
        }else{
            
            if self.userType == "1004"
            {
                return 0
            }else{
                return 1
            }
            
        }
    }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddDocCollectionViewCell",for: indexPath) as! AddDocCollectionViewCell
        
        if collectionView == jbCreaterCollectnView
        {
            if indexPath.section == 0
            {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddDocCollectionViewCell",for: indexPath) as! AddDocCollectionViewCell
                
            cell.docImgV.sd_setImage(with: URL(string: jbCreatertranslatedDoc[indexPath.item].documentUrl!), placeholderImage: UIImage(named: "document"), options: .continueInBackground , completed: nil)
            cell.crossBtn.isHidden = true
                return cell
            }
        }else{
        
        if indexPath.section == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddDocCollectionViewCell",for: indexPath) as! AddDocCollectionViewCell
            if userType == "1004"
            {
                cell.docImgV.sd_setImage(with: URL(string: translatedDoc[indexPath.item].documentUrl!), placeholderImage: UIImage(named: "document"), options: .continueInBackground , completed: nil)
                cell.crossBtn.isHidden = true
            }else{
              cell.docImgV.sd_setImage(with: URL(string: imagesArr[indexPath.item].documentUrl!), placeholderImage: UIImage(named: "document"), options: .continueInBackground , completed: nil)
                cell.crossBtn.isHidden = false
            }
       
            cell.crossBtn.tag = indexPath.item
            cell.crossBtn.addTarget(self, action: #selector(removedClicked(sender:)), for: .touchUpInside)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocsCollectionViewCell",for: indexPath) as! DocsCollectionViewCell
            cell.addBtn.addTarget(self, action: #selector(upDocActn), for: .touchUpInside)
            return cell
        }
        
    }
     return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var images = [URL]()
        
       if collectionView == jbCreaterCollectnView
        {
            for element in jbCreatertranslatedDoc
                   {
                    images.append(URL(string: element.documentUrl!)!)
                   }
                   Utils.imageTapped(index: indexPath.item, imageUrls: images, con: self)
       }else{
       

        if userType == "1004"
        {
            
            for element in translatedDoc
            {
             images.append(URL(string: element.documentUrl!)!)
            }
           
        }else
        {
        for element in imagesArr
           {
            images.append(URL(string: element.documentUrl!)!)
           }
        }
      Utils.imageTapped(index: indexPath.item, imageUrls: images, con: self)
    }
    
    }
    
    func reloadCollection()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal    
        self.translatorDocCV.reloadData()
        translatorDocCV!.collectionViewLayout = layout

    }
    
}
extension TranslatorDocViewController : CropViewControllerDelegate
{
    public func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
        
        uploadImageToAWS(cropped) { (urlStr, error) in
            
            if let url = urlStr
            {
                
                let doc = uploadDocuments(documentTitle: "documentKey".localizableString(loc: Constant.lang), documentUrl: url)
                self.imagesArr.append(doc)
            }
            self.reloadCollection()
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
extension TranslatorDocViewController
{
    //upload translated doc Post Api
    func uploadTransDocApi()
    {
        
        Utils.startLoading(self.view)
        
        var docReq:[[String:Any]] = [[String:Any]]()
        
        for type in imagesArr
        {
            let singleReq:[String:Any] = [
                "documentUrl": type.documentUrl!,
                "documentTitle": type.documentTitle!,
            ]
            docReq.append(singleReq)
        }
        
        let request:[String:Any] = ["ti" : tiId,
                                    "jobCreater" : jobCreaterId,
                                    "job": jobId,
                                    "noOfWords": wordsTF.text!,
                                    "noOfPages": pagesTF.text!,
                                    "documents": docReq]
        Service.sharedInstance.postRequest(Url:Constant.APIs.uploadtranslateddoc,modalName: approvedDocModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        
                        //self.navigationController?.popViewController(animated: true)
                        
                        
                        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "PostJob"), object: nil)
                                               
                                               
                                               for item in self.navigationController?.viewControllers ?? [UIViewController]()
                                               {
                                                   if item is HomeViewController {
                                                       
                                                       self.navigationController?.popToViewController(item, animated: true)
                                                       break;
                                                   }
                                               }
                        
                        
                       
                        AppUtils.showToast(message: (response?.Message)!)
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                }
            }
            
        }
        
    }
    
}

extension TranslatorDocViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width: 50, height: 50)
    }
}


//MARK :- Textfield Check
extension TranslatorDocViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        if textField == self.pagesTF ||  textField == self.wordsTF
        {
            let maxLength = 10
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
