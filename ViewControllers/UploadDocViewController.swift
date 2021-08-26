//
//  UploadDocViewController.swift
//  TolkApp
//
//  Created by sanganan on 5/28/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
import Mantis

struct UploadDocs : Equatable {
    var docURL : String = ""
    var docType : String = ""
    var userId : String = ""
    
    init(url : String, type : String, user : String) {
        self.docURL = url
        self.docType = type
        self.userId = user
    }
}



class UploadDocViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var docTV: UITableView!
    
    @IBOutlet weak var attachDocHeadingLbl: UILabel!
    
    
    //Variables
    var whCell : Int = 0
    var docsArr = [getDocModal]()
    var uploadArr : [UploadDocs] = [UploadDocs]()
    var pageCheck = false
    var userData : UserDetail?

    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.upDocVCT, controller: Constant.Controllers.upDoc)
        attachDocHeadingLbl.text = "attchDocsKey".localizableString(loc: Constant.lang)
        getDocTypApi()
        docTV.register(UINib(nibName: "DocTableViewCell", bundle: nil), forCellReuseIdentifier: "DocTableViewCell")
        docTV.bounces = false
        docTV.delegate = self
        docTV.dataSource = self
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
    
    
    
    @IBAction func nextBtn(_ sender: Any) {
        
        if uploadArr.count == 0 || uploadArr.count < docsArr.count {
            
            AppUtils.showToast(message: Constant.Msg.docErrMsg)
            return
        }
        
        self.uploadDocApi()
        
    }
    
}
extension UploadDocViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.docsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocTableViewCell", for: indexPath) as! DocTableViewCell
        cell.cvHeightCons.constant = 0
        cell.upDocCV.isHidden  = true
        cell.docsLbl.text = self.docsArr[indexPath.row].docName
        
        cell.uploadDoc.tag  = indexPath.row
        cell.uploadDoc.addTarget(self, action: #selector(upDocActn), for: .touchUpInside)
        cell.delegate = self

        let records = uploadArr.filter { (doc) -> Bool in
            return doc.docType == self.docsArr[indexPath.row]._id!
        }
        if records.count > 0
        {
            cell.cvHeightCons.constant = 50
            cell.upDocCV.isHidden  = false
            cell.docsArr = records
            cell.reloadCollection()
        }
        
     
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton()
        btn.tag = indexPath.row
        upDocActn(sender: btn)
        
    }
    
}


extension UploadDocViewController : DocumentDelegate
{
    func docRemoved(doc: UploadDocs) {

        
        uploadArr.removeAll { (document) -> Bool in
            return document == doc
        }
        self.docTV.reloadData()
        
    }
    
    
}


extension UploadDocViewController
{
    @objc override func upDocActn(sender: UIButton)
    {
        
        let alert:UIAlertController=UIAlertController(title: "choseImgKey".localizableString(loc: Constant.lang), message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "choseExstngImgKey".localizableString(loc: Constant.lang), style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.checkLibraryCalling()
        }
        let gallaryAction = UIAlertAction(title: "newPhotoKey".localizableString(loc: Constant.lang), style: UIAlertAction.Style.default )             {
            UIAlertAction in
            self.checkCamera()
        }
        let cancelAction = UIAlertAction(title: "CancelKey".localizableString(loc: Constant.lang), style: UIAlertAction.Style.cancel)       {
            UIAlertAction in
        }
        self.whCell = sender.tag

        // Add the actions
        UIViewController.imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        //self.checkLibraryCalling()
        
    }
}
extension UploadDocViewController
{
    
    //Upload Documents Post Api
    func uploadDocApi()
    {
        
        Utils.startLoading(self.view)
        let url:String = "\(Constant.APIs.baseURL)/uploaddocuments"

        var request:[[String:Any]] = [[String:Any]]()
               
                for type in uploadArr
                {
                   let singleReq:[String:Any] = [
                    "docType": type.docType,
                    "docUrl": type.docURL,
                    "user": type.userId,
                               ]
                   request.append(singleReq)
               }
     
        Service.sharedInstance.postRequestForArray(Url:url,modalName: UploadDocModal.self , parameter: request as [[String:Any]]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        
                        if  self.pageCheck == true
                        {
                            let vc = Constant.Controllers.approval.get() as! ApprovalPViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        else{

                        let vc = Constant.Controllers.addr.get() as! AddressViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                        }
                      //  AppUtils.showToast(message: (response?.Message)!)
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                }
            }}
        
    }
    
    //Get all Documents Type Post Api
    func getDocTypApi()
    {
        
        Utils.startLoading(self.view)
        let url:String = "\(Constant.APIs.baseURL)/getdocumentforusertype"
        guard let uType = AppUtils.getStringForKey(key: Constant.userData.userType!) else{return}
        let request:[String:Any] = ["userType" : uType]  
     //   let request:[String:Any] = ["userType" : 1003]  //hardcoded user Type

        
        Service.sharedInstance.postRequest(Url:url,modalName: GetDocTypeModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        
                        self.docsArr = response!.docList!
                        
                        if let data = self.userData
                        {
                            if let docArray = data.documents
                            {
                                for item in docArray
                                {
                                    
                                    let uploadDoc = UploadDocs(url: item.docUrl!, type: item.docType?._id! ?? "" , user: Constant.appDel.userId)
                                    self.uploadArr.append(uploadDoc)
                                }
                            }
                        }
                        
                        
                        
                        
                        
                      //  AppUtils.showToast(message: (response?.Message)!)
                        
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                    self.docTV.reloadData()
                }
            }}
        
    }
}



extension UploadDocViewController : CropViewControllerDelegate
{
    public func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
        
        self.uploadImageToAWS(cropped) { (urlStr, error) in
            if let url = urlStr
            {
                let uploadDoc = UploadDocs(url: url, type: self.docsArr[self.whCell]._id! , user: Constant.appDel.userId)
                self.uploadArr.append(uploadDoc)
            }
            self.docTV.reloadData()
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
