//
//  ListTableViewCell.swift
//  Laundry_Home
//
//  Created by Sage Lee on 12/1/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {
//    var checkbox: UIImageView!
    var checkButton: UIButton!
    var itemLabel: UITextField!
    var heartImageView: UIImageView!
    var item: LaundryList!
    var row: Int!
    var indexPath: IndexPath!
    
    let padding: CGFloat = 20
    let labelHeight: CGFloat = 30
    let imageWidth: CGFloat = 20
    let imageHeight: CGFloat = 20
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        checkbox = UIImageView(image: UIImage(named: "unchecked.jpg"))
//        checkbox.translatesAutoresizingMaskIntoConstraints = false
//        checkbox.contentMode = .scaleAspectFit
//        contentView.addSubview(checkbox)
        
        checkButton = UIButton()
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.setImage(UIImage(named: "unchecked.jpg"), for: .normal)
        checkButton.addTarget(self, action: #selector(boxChange), for: .touchUpInside)
        contentView.addSubview(checkButton)
        
        itemLabel = UITextField()
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.text = ""
        itemLabel.placeholder = ""
        itemLabel.textAlignment = .left
        itemLabel.backgroundColor = .white
        itemLabel.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        itemLabel.textColor = .darkGray
        contentView.addSubview(itemLabel)
        
        heartImageView = UIImageView(image: #imageLiteral(resourceName: "heart"))
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        heartImageView.contentMode = .scaleAspectFit
        heartImageView.isHidden = true
        contentView.addSubview(heartImageView)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            checkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkButton.heightAnchor.constraint(equalToConstant: imageHeight),
            checkButton.widthAnchor.constraint(equalToConstant: imageWidth)
            ])
        
        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            itemLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 10),
            itemLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            itemLabel.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
        NSLayoutConstraint.activate([
            heartImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding * -1),
            heartImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            heartImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            heartImageView.widthAnchor.constraint(equalToConstant: imageWidth)
            ])
        
        super.updateConstraints()
    }
    
    func configure(for item: LaundryList) {
        itemLabel.text = item.item
    }
    
    func toggleHeart(for item: LaundryList) {
        heartImageView.isHidden = !item.isFavorite
        if heartImageView.isHidden == false {
            itemLabel.textColor = UIColor.init(red: 75/255, green: 33/255, blue: 130/255, alpha: 1.0)
        }
        if heartImageView.isHidden == true {
            itemLabel.textColor = UIColor.init(red: 67/255, green: 135/255, blue: 183/255, alpha: 1.0)
        }
    }
    
    @objc func boxChange(sender: UIButton!) {
        if checkButton.backgroundImage(for: .normal) == UIImage(named: "unchecked.jpg") {
            checkButton.setImage(UIImage(named: "checked.jpg"), for: .normal)
        } else {
            checkButton.setImage(UIImage(named: "unchecked.jpg"), for: .normal)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

