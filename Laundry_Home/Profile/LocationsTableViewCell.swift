//
//  LocationsTableViewCell.swift
//  Laundry_Home
//
//  Created by Sage Lee on 12/1/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

class LocationsViewCell: UITableViewCell {
    var locationLabel: UIButton!
    var location: LocationsList!
    var row: Int!
    var indexPath: IndexPath!
    
    let padding: CGFloat = 20
    let labelHeight: CGFloat = 30
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        locationLabel = UIButton()
        locationLabel.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        contentView.addSubview(locationLabel)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    func configure(for location: LocationsList) {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
