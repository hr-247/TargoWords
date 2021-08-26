//
//  CardDetailsViewController.swift
//  TolkApp
//
//  Created by sanganan on 7/2/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class CardDetailsViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var addcardBtn: UIButton!
    @IBOutlet weak var creditCardsTV: UITableView!
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var noCreditcardLbl: UILabel!
    @IBOutlet weak var creditCrdHeadng: UILabel!
    
    
    //Variables
    var cardListArr = [cardModal]()
    var brandNme = ""
    var last4Digits = ""
    var expMonth = Int()
    var expYear = Int()
    var cardId = ""
    var payProfileId = ""
    var defaultCard = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.cardDetVCT, controller: Constant.Controllers.cardDetails)
        
        if let profile = AppUtils.getStringForKey(key: Constant.userData.paymentProfileId)
        {
            payProfileId = profile
        }
        
        creditCrdHeadng.text = "creditCrdKey".localizableString(loc: Constant.lang)
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshPage), name: NSNotification.Name(rawValue:"cardadd"), object: nil)
        
        noCreditcardLbl.isHidden = true
        Utils.startLoading(self.view)
        cardListApi()
        self.creditCardsTV.register(UINib(nibName: "CreditCardsTableViewCell", bundle: nil), forCellReuseIdentifier: "CreditCardsTableViewCell")
        self.creditCardsTV.delegate = self
        self.creditCardsTV.dataSource = self
        refreshControl = Utils.sharedInstance.addRefreshControl()
        self.creditCardsTV.refreshControl = refreshControl
        Utils.sharedInstance.refreshChanged = { () in
            self.cardListApi()
            
        }
        
    }
    
    @objc func refreshPage()
    {
        cardListApi()
    }
    
    @IBAction func addcardActn(_ sender: Any) {
        
        let vc =  Constant.Controllers.payment.get() as! PaymentViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func removeActn(sender : UIButton)
    {
        let alertController = UIAlertController(title: "removeCardKey".localizableString(loc: Constant.lang), message: "removeCardMsgKey".localizableString(loc: Constant.lang), preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "yesK".localizableString(loc: Constant.lang), style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.cardRemoveApi(index: sender.tag)
        }
        
        let cancelAction = UIAlertAction(title: "noK".localizableString(loc: Constant.lang), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancelled")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
}
extension CardDetailsViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cardListArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CreditCardsTableViewCell", for: indexPath) as! CreditCardsTableViewCell
        cell.defaultCrdLbl.isHidden = true
        
        
        if let brand = cardListArr[indexPath.row].brand
        {
            brandNme = brand
        }
        if let lastDigits = cardListArr[indexPath.row].last4
        {
            last4Digits = lastDigits
        }
        cell.bankNameLbl.text = "\(brandNme) \("cardKey".localizableString(loc: Constant.lang)) ****\(last4Digits)"
        //        if let nme = cardListArr[indexPath.row].name
        //        {
        //            cell.accHolderNmeLbl.text = nme
        //        }else{
        //            cell.accHolderNmeLbl.text = ""
        //        }
        if let month = cardListArr[indexPath.row].exp_month
        {
            expMonth = month
        }
        if let year = cardListArr[indexPath.row].exp_year
        {
            expYear = year
        }
        cell.cardExpiryLbl.text = "\("exprsKey".localizableString(loc: Constant.lang)) \(expMonth)/\(expYear)"
        cell.removeBtn.setTitle("removeKey".localizableString(loc: Constant.lang), for: .normal)
        cell.removeBtn.tag = indexPath.row
        cell.removeBtn.addTarget(self, action: #selector(removeActn(sender:)), for: .touchUpInside)
        
         let cId = cardListArr[indexPath.row].id
        
        if cardListArr.count == 1
        {
            cell.defaultCrdLbl.isHidden = true
            
        }else{
       
        
        if self.defaultCard == cId
        {
            cell.defaultCrdLbl.isHidden = false
            cell.defaultCrdLbl.text = "defaultCrdKey".localizableString(loc: Constant.lang)
            cell.defaultCrdLbl.layer.cornerRadius = 15
            cell.defaultCrdLbl.layer.masksToBounds = true
        }
        }
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cardListArr.count == 1
        {
            
            return
        }
        
        let cId = cardListArr[indexPath.row].id
        
        if self.defaultCard == cId
        {
            
            
            return
        }
        
        let alertController = UIAlertController(title: "defaultCardKey".localizableString(loc: Constant.lang), message: "defaultCardMsgKey".localizableString(loc: Constant.lang), preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "yesK".localizableString(loc: Constant.lang), style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.cardDefaultApi(index : indexPath.row)
        }
        
        let cancelAction = UIAlertAction(title: "noK".localizableString(loc: Constant.lang), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancelled")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
}
extension CardDetailsViewController
{
    
    //Credit Card List Post Api
    func cardListApi()
    {
        
        let request:[String:Any] = ["profileId" : payProfileId]
        
        Service.sharedInstance.postRequest(Url:Constant.APIs.getpaymentprofiledetails,modalName: CreditCardDetailsModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                self.refreshControl.endRefreshing()
                if let res = response?.Success{
                    if res == 1{
                        
                        if let defaultId = response?.customer?.default_source
                        {
                            self.defaultCard = defaultId
                        }
                        
                        
                        self.cardListArr = (response?.customer?.sources!.data)!
                        
                        if self.cardListArr.count == 0 {
                            self.noCreditcardLbl.isHidden = false
                            self.noCreditcardLbl.text = "noCrditCrdKey".localizableString(loc: Constant.lang)
                            
                        }
                        else {
                            self.noCreditcardLbl.isHidden = true
                        }
                        // AppUtils.showToast(message: (response?.Message)!)
                        
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                    self.creditCardsTV.reloadData()
                }
            }}
        
    }
    
    //Credit card Remove Api
    func cardRemoveApi(index : Int)
    {
        
        Utils.startLoading(self.view)
        if let cId = cardListArr[index].id
        {
            self.cardId = cId
        }
        
        let request:[String:Any] = ["profileId" : payProfileId, "cardId" : cardId]
        
        Service.sharedInstance.postRequest(Url:Constant.APIs.removecard,modalName: approvedDocModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        
                        
                        if self.defaultCard == self.cardId
                        {
                                      
                            self.cardListApi()
                                      
                        }
                        self.cardListArr.remove(at: index)
                            self.creditCardsTV.reloadData()
                        
                      
                        AppUtils.showToast(message: (response?.Message)!)
                        
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                    //   self.creditCardsTV.reloadData()
                }
            }}
        
    }
    
    //Make Credit Card Default Api
    func cardDefaultApi(index : Int)
    {
        
        Utils.startLoading(self.view)
        if let cId = cardListArr[index].id
        {
            self.cardId = cId
        }
        
        let request:[String:Any] = ["profileId" : payProfileId, "source" : cardId]
        
        Service.sharedInstance.postRequest(Url:Constant.APIs.setdefaultpaymentsource,modalName: DefaultCardModal.self , parameter: request as [String:Any]) { (response, error) in
            DispatchQueue.main.async {
                Utils.stopLoading()
                if let res = response?.Success{
                    if res == 1{
                        
                        self.defaultCard = (response?.resp?.default_source)!
                        
                        AppUtils.showToast(message: (response?.Message)!)
                        
                        
                    }else{
                        AppUtils.showToast(message: (response?.Message)!)
                    }
                    self.creditCardsTV.reloadData()
                }
            }}
        
    }
}
