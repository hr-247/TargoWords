//
//  DocTableViewCell.swift
//  TolkApp
//
//  Created by sanganan on 5/28/20.
//  Copyright © 2020 sanganan. All rights reserved.

import UIKit
import SDWebImage


protocol DocumentDelegate {
    func docRemoved (doc : UploadDocs)
    
}


class DocTableViewCell: UITableViewCell {
    
    
    //outlets
    @IBOutlet weak var docsLbl: UILabel!
    @IBOutlet weak var uploadDoc: UIButton!
    @IBOutlet weak var upDocCV: UICollectionView!
    @IBOutlet weak var cvHeightCons: NSLayoutConstraint!
    var delegate : DocumentDelegate?
    //variables
    //var tag: Int
    var docsArr : [UploadDocs] = [UploadDocs]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        upDocCV.register(UINib(nibName: "AddDocCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddDocCollectionViewCell")
        upDocCV.delegate = self
        upDocCV.dataSource = self
    }
    func reloadCollection()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        self.upDocCV.reloadData()
        upDocCV!.collectionViewLayout = layout

    }
    
    @objc func removedClicked(sender : UIButton)
    {
        self.delegate?.docRemoved(doc: self.docsArr[sender.tag])
    }
}

extension DocTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.docsArr.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddDocCollectionViewCell", for: indexPath) as! AddDocCollectionViewCell
        cell.docImgV.sd_setImage(with: URL(string: docsArr[indexPath.item].docURL), placeholderImage: UIImage(named: "document"), options: .continueInBackground , completed: nil)
        cell.crossBtn.tag = indexPath.item
    
        cell.crossBtn.addTarget(self, action: #selector(removedClicked(sender:)), for: .touchUpInside)
        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var images = [URL]()
        for element in docsArr
        {
            images.append(URL(string: element.docURL)!)
        }
        
        Utils.imageTapped(index: indexPath.item, imageUrls: images, con: parentViewController!)
        
    }
    
}



extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
