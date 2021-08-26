//
//  MyCustomHeader.swift
//  TolkApp
//
//  Created by sanganan on 5/27/20.
//  Copyright © 2020 sanganan. All rights reserved.
//

import UIKit
class MyCustomHeader : UITableViewHeaderFooterView{
    let title = UILabel()
    let btn = UIButton()
    let addBtn = UIButton()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureContents() {
        btn.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(btn)
        contentView.addSubview(title)
        contentView.addSubview(addBtn)
        NSLayoutConstraint.activate([
            btn.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            btn.widthAnchor.constraint(equalToConstant: 20),
            btn.heightAnchor.constraint(equalToConstant: 20),
            btn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: btn.trailingAnchor,
                                           constant: 10),
            title.trailingAnchor.constraint(equalTo:
                contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            btn.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 15),
            btn.widthAnchor.constraint(equalToConstant: 20),
            btn.heightAnchor.constraint(equalToConstant: 20),
            btn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}





