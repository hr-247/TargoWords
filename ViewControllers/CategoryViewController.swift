//
//  CategoryViewController.swift
//  TolkApp
//
//  Created by sanganan on 6/16/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

protocol   sendCatProtocol{
    func sendDataBack(cat: catListModal)
}

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var catTV: UITableView!
    
    //Variables
    var delegate : sendCatProtocol?
    var catArr = [catListModal]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonNavigationBar(title: Constant.navTitles.catVCT, controller: Constant.Controllers.category)
        catTV.backgroundView = UIImageView(image: UIImage(named: "whitebg"))
        getCategory()
        catTV.register(UINib(nibName: "SelLangTableViewCell", bundle: nil), forCellReuseIdentifier: "SelLangTableViewCell")
        catTV.dataSource = self
        catTV.delegate = self
        self.catTV.tableFooterView = UIView(frame: .zero)
        
    }
    override func backBtn() {
        self.dismiss(animated: true, completion: nil)
    }

   
}
extension CategoryViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.catArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelLangTableViewCell", for: indexPath) as! SelLangTableViewCell
        if let category = catArr[indexPath.row].name
        {
            cell.langLbl.text = category
        }
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        self.delegate?.sendDataBack(cat: catArr[indexPath.row])
       dismiss(animated: true, completion: nil)
        
    }
    
    
}
extension CategoryViewController
{
    //Category Get Api
    func getCategory()
    {
       Utils.startLoading(self.view)
              let url:String = "\(Constant.APIs.baseURL)/getCategory"
             
              
        Service.sharedInstance.getRequest(Url: url, modalName: CategoryModal.self, completion: { (response, error) in
                  DispatchQueue.main.async {
                      Utils.stopLoading()
                      if let res = response?.Success{
                          if res == 1{
                              
                            self.catArr = (response?.catlist)!
                           //   AppUtils.showToast(message: (response?.Message)!)
                              
                          }else{
                              AppUtils.showToast(message: (response?.Message)!)
                          }
                          self.catTV.reloadData()
                      }}
    })
}
}
