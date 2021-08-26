//
//  UpdateLangProfileTblViewCell.swift
//  TolkApp
//
//  Created by saurav sinha on 19/06/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit

class UpdateLangProfileTblViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var langCV: UICollectionView!
    @IBOutlet weak var selLang1: UIButton!
    @IBOutlet weak var selLang2: UIButton!
    
    //Variables
    var langArr = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        langCV.register(UINib(nibName: "RoleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RoleCollectionViewCell")
        langCV.delegate = self
        langCV.dataSource = self
        // Initialization code
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return langArr.count
    }
    func reloadCollection()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 80, height: 160)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        langCV!.collectionViewLayout = layout
        self.langCV.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoleCollectionViewCell", for: indexPath) as! RoleCollectionViewCell
        
        return cell
    }
    
}
