//
//  FilterCollectionViewCell.swift
//  Laundry_Home
//
//  Created by Sage Lee on 11/30/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    var filterLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
//        contentView.layer.borderWidth = 3
//        contentView.layer.borderColor = UIColor(red:0.37, green:0.61, blue:0.86, alpha:1.0).cgColor
        
        filterLabel = UILabel()
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.textColor = UIColor(red: 0.37, green: 0.61, blue: 0.86, alpha: 1.0)
        filterLabel.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        filterLabel.textAlignment = .center
        contentView.addSubview(filterLabel)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            filterLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            filterLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            filterLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        super.updateConstraints()
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                filterLabel.textColor = .darkGray
            } else {
                filterLabel.textColor = UIColor(red: 0.37, green: 0.61, blue: 0.86, alpha: 1.0)
            }
        }
    }
    
    func configure(with filter: Filter) {
        filterLabel.text = "\(getFilterString(filter.filterVal))"
    }
    
    private func getFilterString( _ filterVal: FilterName) -> String {
        switch filterVal {
        case .washers:
            return "washers"
        case .dryers:
            return "dryers"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
