//
//  InfoCollectionViewCell.swift
//  Laundry_Home
//
//  Created by Sage Lee on 12/1/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    
    var nameLabel: UILabel!
    var status: UILabel!
    
    let padding: CGFloat = 15
    let labelHeight: CGFloat = 16
    weak var parentVC: InfoViewController?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor(red:0.37, green:0.61, blue:0.86, alpha:1.0).cgColor
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        nameLabel.textColor = UIColor(red:0.37, green:0.61, blue:0.86, alpha:1.0)
        contentView.addSubview(nameLabel)
        
        status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        contentView.addSubview(status)
        
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding*2),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            status.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding*2),
            status.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            status.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        super.updateConstraints()
    }
    
    func configure(with machine: Machine) {
       
        if let parentViewLabel = self.parentVC?.locationLabel {
            nameLabel.text = parentViewLabel.text
        } else {
            nameLabel.text = "machine"
        }
        status.text = "\(getStatusVal(machine.status))"
        
        if status.text == "OPEN" {
            status.textColor = UIColor(red:0.68, green:0.87, blue:0.67, alpha:1.0)
        } else if status.text == "IN USE" {
            status.textColor = UIColor(red:1.00, green:0.97, blue:0.73, alpha:1.0)
        } else {
            status.textColor = UIColor(red:0.95, green:0.74, blue:0.73, alpha:1.0)
        }
    }
    
    private func getStatusVal(_ status: StatusValue) -> String {
        switch status {
        case .green:
            return "OPEN"
        case .yellow:
            return "IN USE"
        case .red:
            return "BROKEN"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
