//
//  HomeCollectionReusableView.swift
//  Laundry_Home
//
//  Created by Sage Lee on 11/30/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

class HomeCollectionReusableView: UICollectionReusableView {
    
    var headerLabel: UILabel!
    let padding: CGFloat = 15
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headerLabel = UILabel()
        headerLabel.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.textAlignment = .center
        headerLabel.textColor = .white
        addSubview(headerLabel)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding*2),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
        super.updateConstraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
