//
//  JobDetailTableViewCell.swift
//  TolkApp
//
//  Created by sanganan on 5/29/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit



class JobDetailTableViewCell: UITableViewCell {
    
    var docsArr = [uploadDocModal]()
    
    
    @IBOutlet weak var cvheightCons: NSLayoutConstraint!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var dscLbl: UILabel!
    @IBOutlet weak var translatorDocCV: UICollectionView!
    @IBOutlet weak var lineVw: UIView!
    
    @IBOutlet weak var billBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        translatorDocCV.register(UINib(nibName: "AddDocCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddDocCollectionViewCell")
        translatorDocCV.delegate = self
        translatorDocCV.dataSource = self
    }
    func reloadCollection()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        self.translatorDocCV.reloadData()
        translatorDocCV!.collectionViewLayout = layout
        
    }
    
}

extension JobDetailTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.docsArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddDocCollectionViewCell", for: indexPath) as! AddDocCollectionViewCell
        if let url = docsArr[indexPath.item].documentUrl
        {
        cell.docImgV.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "document"), options: .continueInBackground , completed: nil)
        }
        cell.crossBtn.isHidden = true
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var images = [URL]()
        for element in docsArr
        {
            if let url = element.documentUrl
            {
            images.append(URL(string: url)!)
            }
        }
        
        Utils.imageTapped(index: indexPath.item, imageUrls: images, con: parentViewController!)
        
    }
    
    
}


