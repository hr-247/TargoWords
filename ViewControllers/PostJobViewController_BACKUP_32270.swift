//
//  PostJobViewController.swift
//  TolkApp
//
//  Created by sanganan on 5/19/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl



class PostJobViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var segTI: ScrollableSegmentedControl!
    @IBOutlet weak var jobTV: UITableView!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var pickrDoneBtn: UIButton!
    @IBOutlet weak var pickerBg: UIView!
    
    
    //variables
   // var intrFields : IntrFieldsHelper = IntrFieldsHelper()
    var whArr : Int = 0
    var dateTime : String = String()
    var imageChosen = UIImage()
    var optn = ""
    var selectedLang = ""
    var selectedCat = ""
    var jobTyp : Int? = Int()
    var jobDate : String? = ""
    var addr : String? = ""
    var locTyp : String? = ""
    var locCordinate : [Float?] = [Float]()
    var zipCd : String? = ""
    var duration : Int? = 0
    var organization : String? = ""
    var sourceLng : String? = ""
    var destLang : String? = ""
    var category : String? = ""
    var needSwormIntr : Bool? = false
    var ContactPerson : String? = ""
    var converManager : String? = ""
    var email : String? = ""
    var telephNo : String? = ""
    var jobDsc : String? = ""
    var jobStatus : Int? = 0
    var assignedTo : String? = ""
    var jobNo : Int? = 0
    var remarks : String? = ""
    var service : String? = ""
    var needStamp : Bool? = false
    var manyWords : Int? = 0
    var manyPages : Int? = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonNavigationBar(title: Constant.navTitles.postJVCT, controller: Constant.Controllers.postJob)
        segTIF()
        UIViewController.imagePicker.allowsEditing = true
        jobTV.backgroundView = UIImageView(image: UIImage(named: "whitebg"))
        self.jobTV.register(UINib(nibName: "IntrPrtrTVCell", bundle: nil), forCellReuseIdentifier: "IntrPrtrTVCell")
        jobTV.dataSource = self
        jobTV.delegate = self
//        if let data = Constant.appDel.intrFieldModal
//               {
//                   self.intrFields = data
//
//               }else
//               {
//                   self.intrFields = IntrFieldsHelper.init()
//               }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    
    @IBAction func nxtBtn(_ sender: Any) {
        self.view.endEditing(true)
        postJobApi()
        // self.navigationController?.popViewController(animated: true)
    }
    
   
    
    @IBAction func pickrActn(_ sender: Any) {
        let   dateTimeFormat = "EE, dd MMM, yyyy hh:mm a"
        self.dateTime = AppUtils.getParticularTimeFormat(format: dateTimeFormat, date: dateTimePicker.date)
        self.dateTimePicker.isHidden = true
        self.pickrDoneBtn.isHidden = true
        self.pickerBg.isHidden = true
        jobTV.reloadData()
        
    }
    
    public override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        if let capturedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            picker.dismiss(animated: true, completion: nil)
            self.imageChosen  = capturedImage
            jobTV.reloadData()
        }
    }
<<<<<<< HEAD
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 301
        {
            intrFields.addr = textField.text
        }
        
    }
    
    
    
=======
 
>>>>>>> 29d8fb1b05bd37a78699ee8627642bddacf3a797
}
extension PostJobViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if whArr == 0
        {
            return classConst.interpArr.count
        }else{
            return classConst.transArr.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IntrPrtrTVCell", for: indexPath) as! IntrPrtrTVCell
        cell.jobDescTF.delegate = self
        
        cell.durBtn.isHidden = true
        cell.durWdCons.constant = 0
        cell.durTraCons.constant = 0
        cell.cvHeightCons.constant = 0
        cell.jbPostCV.isHidden = true
        cell.jobDescTF.placeHolderColor = UIColor.plcholC
        cell.jobDescTF.isUserInteractionEnabled = true
        cell.dropDBtn.isHidden = true
        cell.opt2Btn.isHidden = true
        cell.optBtn.isHidden = true
        cell.optDscL.isHidden = true
        cell.optDsc2L.isHidden = true
        cell.opt3Btn.isHidden = true
        cell.optDsc3L.isHidden = true
        cell.jobDescTF.text = ""
        
        if whArr == 0{
            cell.jobDescTF.placeholder = classConst.interpArr[indexPath.row]
            
            //            if indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8
            //            {
            //                cell.jobDescTF.placeHolderColor = UIColor.txtFldC
            //                cell.jobDescTF.isUserInteractionEnabled = false
            //                cell.dropDBtn.isHidden = false
            //            }
            
            if indexPath.row == 0
            {
                cell.jobDescTF.isUserInteractionEnabled = false
                cell.jobDescTF.text = self.dateTime
                
                let date = cell.jobDescTF.text!
                self.jobDate = date
            }
            
            if indexPath.row == 1
            {
                cell.jobDescTF.placeHolderColor = UIColor.txtFldC
                cell.jobDescTF.isUserInteractionEnabled = false
                cell.opt2Btn.isHidden = false
                cell.optBtn.isHidden = false
                cell.optDscL.isHidden = false
                cell.optDsc2L.isHidden = false
                cell.opt3Btn.isHidden = false
                cell.optDsc3L.isHidden = false
                let tag = cell.btnTag
                switch tag {
                case 0:
                    optn = "Personal"
                    break
                case 1:
                    optn = "Video call"
                    break
                default:
                    optn = "Telephonic"
                    
                }
                self.service = optn
            }
            
            if indexPath.row == 2
            {
<<<<<<< HEAD
                cell.jobDescTF.tag = 301 // lets assume that 301 tag is for interpreter address field
                cell.jobDescTF.text = self.intrFields.addr
=======
                
                let address = cell.jobDescTF.text!
                self.addr = address
>>>>>>> 29d8fb1b05bd37a78699ee8627642bddacf3a797
            }
            
            //            if indexPath.row == 3
            //            {
            //            cell.jobDescTF.placeHolderColor = UIColor.txtFldC
            //            cell.jobDescTF.isUserInteractionEnabled = false
            //            cell.dropDBtn.isHidden = false
            //                 self.intrFields?.jobDate = cell.jobDescTF.text
            //
            //            }
            
            if indexPath.row == 3
            {
                cell.durBtn.isHidden = false
                cell.durWdCons.constant = 20
                cell.durTraCons.constant = 10
                let duratn = Int(cell.jobDescTF.text!) ?? 0
                self.duration = duratn
            }
            if indexPath.row == 4
            {
                let organiztn = cell.jobDescTF.text!
                self.organization = organiztn
            }
            if indexPath.row == 5
            {
                cell.dropDBtn.addTarget(self, action: #selector(selLangActn), for: .touchUpInside)
                cell.jobDescTF.placeHolderColor = UIColor.txtFldC
                cell.jobDescTF.isUserInteractionEnabled = false
                cell.dropDBtn.isHidden = false
                self.sourceLng = self.selectedLang
            }
            if indexPath.row == 6
            {
                cell.dropDBtn.addTarget(self, action: #selector(selLangActn), for: .touchUpInside)
                cell.jobDescTF.placeHolderColor = UIColor.txtFldC
                cell.jobDescTF.isUserInteractionEnabled = false
                cell.dropDBtn.isHidden = false
                self.destLang = self.selectedLang
            }
            
            if indexPath.row == 7
            {
                cell.jobDescTF.placeHolderColor = UIColor.txtFldC
                cell.jobDescTF.isUserInteractionEnabled = false
                cell.dropDBtn.isHidden = false
                cell.dropDBtn.addTarget(self, action: #selector(getcat), for: .touchUpInside)
                self.category = self.selectedCat
                
            }
            
            
            if indexPath.row == 8
            {
                cell.jobDescTF.placeHolderColor = UIColor.txtFldC
                cell.jobDescTF.isUserInteractionEnabled = false
                cell.opt2Btn.isHidden = false
                cell.optBtn.isHidden = false
                cell.optDscL.isHidden = false
                cell.optDscL.text = Constant.vcTitles.swoYes
                cell.optDsc2L.isHidden = false
                cell.optDsc2L.text = Constant.vcTitles.swoNo
                let tag = cell.btnTag
                switch tag {
                case 0:
                    optn = "Yes"
                    break
                default:
                    optn = "No"
                    
                }
                
                self.needSwormIntr = Bool(optn) ?? false
            }
            if indexPath.row == 9
            {
                let contactP = cell.jobDescTF.text!
                self.ContactPerson = contactP
            }
            if indexPath.row == 10
            {
                let manager = cell.jobDescTF.text!
                self.converManager = manager
            }
            if indexPath.row == 11
            {
//                let email = isValidEmail(testStr: (cell.jobDescTF.text?.trimWhiteSpaces())!)
//                if email == true{
                let em = cell.jobDescTF.text!
                    self.email = em
            }
            if indexPath.row ==  12
            {
                cell.jobDescTF.keyboardType = .numberPad
                let no = cell.jobDescTF.text!
                self.telephNo = no
            }
            if indexPath.row == 13
            {
                let dsc = cell.jobDescTF.text!
                self.jobDsc = dsc
            }
            
        }
            
        else{
            cell.jbPostCV.isHidden = true
            cell.jobDescTF.placeholder = classConst.transArr[indexPath.row]
            if indexPath.row == 0
            {
                self.jobDate = cell.jobDescTF.text!
            }
            if indexPath.row == 1
            {
                self.addr = cell.jobDescTF.text!
            }
            
            //            if indexPath.row == 2
            //            {
            //                self.intrFields?.duration = Int(cell.jobDescTF.text!)
            //            }
            if indexPath.row == 2
            {
                self.organization = cell.jobDescTF.text!
            }
            
            if indexPath.row == 3
            {
                cell.jobDescTF.placeHolderColor = UIColor.txtFldC
                cell.jobDescTF.isUserInteractionEnabled = false
                cell.dropDBtn.isHidden = false
                cell.dropDBtn.addTarget(self, action: #selector(selLangActn), for: .touchUpInside)
                self.sourceLng = cell.jobDescTF.text!
            }
            if indexPath.row == 4
            {
                cell.jobDescTF.placeHolderColor = UIColor.txtFldC
                cell.jobDescTF.isUserInteractionEnabled = false
                cell.dropDBtn.isHidden = false
                cell.dropDBtn.addTarget(self, action: #selector(selLangActn), for: .touchUpInside)
                self.destLang = cell.jobDescTF.text!
            }
            if indexPath.row == 5
            {
                self.ContactPerson = cell.jobDescTF.text!
            }
            if indexPath.row == 6
            {
                self.email = cell.jobDescTF.text!
            }
            if indexPath.row == 7
            {
                self.telephNo = cell.jobDescTF.text!
            }
            if indexPath.row == 8
            {
                self.manyPages = Int(cell.jobDescTF.text!) ?? 0
            }
            
            if indexPath.row == 9
            {
                self.manyWords = Int(cell.jobDescTF.text!) ?? 0
                
            }
            if indexPath.row == 10
            {
                cell.jobDescTF.placeHolderColor = UIColor.txtFldC
                cell.jobDescTF.isUserInteractionEnabled = false
                cell.opt2Btn.isHidden = false
                cell.optBtn.isHidden = false
                cell.optDscL.isHidden = false
                cell.optDscL.text = Constant.vcTitles.swoYes
                cell.optDsc2L.isHidden = false
                cell.optDsc2L.text = Constant.vcTitles.swoNo
                
                let tag = cell.btnTag
                switch tag {
                case 0:
                    optn = "Yes"
                    break
                default:
                    optn = "No"
                    
                }
                self.needStamp = Bool(optn) ?? false
            }
            if indexPath.row == 11
            {
                cell.jobDescTF.placeHolderColor = UIColor.txtFldC
                cell.jobDescTF.isUserInteractionEnabled = false
                cell.dropDBtn.isHidden = false
                cell.dropDBtn.setImage(UIImage(named: "camera"), for: .normal)
                cell.dropDBtn.addTarget(self, action: #selector(upDocActn), for: .touchUpInside)
                cell.jbPostCV.isHidden = false
                cell.cvHeightCons.constant = 50
                cell.docsArr.append(imageChosen)
                cell.reloadCollection()
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if whArr == 0{
            if indexPath.row == 0
            {
                self.dateTimePicker.minimumDate = NSDate() as Date
                self.dateTimePicker.datePickerMode = .dateAndTime
                self.dateTimePicker.isHidden = false
                self.pickerBg.isHidden = false
                self.pickrDoneBtn.isHidden = false
            }
            
            if indexPath.row == 5 || indexPath.row == 6
            {
                
                let btn = UIButton(type: .custom)
                btn.tag = indexPath.row
                self.selLangActn(btn)
            }
           if  indexPath.row == 7
           {
            let btn = UIButton(type: .custom)
            btn.tag = indexPath.row
            self.getcat(btn)
            }
            
        }else{
            
            if indexPath.row == 5 || indexPath.row == 6
            {
                let btn = UIButton(type: .custom)
                btn.tag = indexPath.row
                self.selLangActn(btn)
            }
            
        }
        
      
    }
}
extension PostJobViewController
{
    private  func segTIF()
    {
        segTI.segmentStyle = .textOnly
        let txt = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.white]
        segTI.setTitleTextAttributes(txt, for: .normal)
        segTI.insertSegment(withTitle:Constant.vcTitles.interp ,at:0)
        segTI.insertSegment(withTitle:Constant.vcTitles.transl ,at:1)
        segTI.underlineSelected = true
        segTI.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        segTI.selectedSegmentIndex = 0
        segTI.tintColor = UIColor.undrC
        segTI.backgroundColor = UIColor.navBarC
        segTI.fixedSegmentWidth = true
    }
    @objc private func segmentSelected(sender:ScrollableSegmentedControl) {
        self.whArr = segTI.selectedSegmentIndex
        jobTV.reloadData()
    }
    
    
    //POST JOB POST API
    func postJobApi()
    {
        Utils.startLoading(self.view)
        let url:String = "\(Constant.APIs.baseURL)/postjob"
        let uId = AppUtils.getStringForKey(key: Constant.userData.id)
        let request:[String:Any] = [
            
            "userCreatedBy": uId!,
            "jobType": jobTyp!,
            "jobDate": jobDate!,
            "address": addr!,
            "location": [
                "type": "Point",
                "coordinates": [0.0, 0.0]
            ],
            
            "zipCode": zipCd!,
            "duration": duration!,
            "organization": organization!,
            "sourceLanguage": sourceLng!,
            "destinationLanguage": destLang!,
            "category": category!,
            "needSwormIntepretor": needSwormIntr!,
            "contactPerson": ContactPerson!,
            "converationManager": converManager!,
            "email": email!,
            "telephone": telephNo!,
            "jobDescription": jobDsc!,
            "jobStatus": jobStatus!,
            "assignedTo": assignedTo!,
            "jobNumber": jobNo!,
            "remarks": remarks!,
            "service": service!
        ]
        
        Service.sharedInstance.postRequest(Url:url,modalName: PostJobModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        
                        
                        let vc = Constant.Controllers.home.get() as! HomeViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                        AppUtils.showToast(message: (response?.Message)!)
                        
                        
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                    self.jobTV.reloadData()
                }
            }
            
        }
        
    }
    
    
}

extension PostJobViewController: sendDataProtocol,sendCatProtocol
{
    func sendDataBack(language: LangsModal) {
<<<<<<< HEAD
        self.dismiss(animated: true)
               self.selectedLang = language.language!
               self.jobTV.reloadData()
    }
    
=======
<<<<<<< HEAD
=======
        
    }
    
    func sendDataBack(fromLang: String) {
>>>>>>> f2fa3e9734af3bc81c0738d0f1d046e752d2a8d4
        self.dismiss(animated: true)
        self.selectedLang = language.language!
        self.jobTV.reloadData()

        
    }
    
    
>>>>>>> 29d8fb1b05bd37a78699ee8627642bddacf3a797
    func sendDataBack(cat: String)
    {
        self.dismiss(animated: true)
        self.selectedCat = cat
        self.jobTV.reloadData()
    }
    
    
}

<<<<<<< HEAD


=======
extension PostJobViewController
{
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    //MARK:- TEXT FIELD DELEGATE METHOD
   
 
>>>>>>> 29d8fb1b05bd37a78699ee8627642bddacf3a797

}

