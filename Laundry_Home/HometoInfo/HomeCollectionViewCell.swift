//
//  HomeCollectionViewCell.swift
//  Laundry_Home
//
//  Created by Sage Lee on 11/27/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

protocol Timeable {
    func startTimer(duration: Int)
    func reportBroken(set: Bool)
}

class HomeCollectionViewCell: UICollectionViewCell {
    
    var nameLabel: UILabel!
    var timeLabel: UILabel!
    var status: UIView!
    var durationVal: Int!
    var isMine: Bool!
    
    let padding: CGFloat = 12
    let labelHeight: CGFloat = 16
    
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
        
        timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = "00:00:00"
        timeLabel.font = UIFont(name: "ArialRoundedMTBold", size: 14)
        timeLabel.textColor = UIColor(red:0.37, green:0.61, blue:0.86, alpha:1.0)
        contentView.addSubview(timeLabel)
        
        status = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        status.translatesAutoresizingMaskIntoConstraints = false
        status.backgroundColor = UIColor(red:0.68, green:0.87, blue:0.67, alpha:1.0)
        status.layer.cornerRadius = status.frame.width/2
        contentView.addSubview(status)
        
//        getMachineInfo()
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding*2),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            timeLabel.trailingAnchor.constraint(equalTo: status.leadingAnchor, constant: -padding),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            status.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding*2),
            status.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            status.widthAnchor.constraint(equalToConstant: CGFloat(20)),
            status.heightAnchor.constraint(equalToConstant: CGFloat(20))
            ])
        
        super.updateConstraints()
    }
    
//    func getMachineInfo() {
//        NetworkManager.getMachinesinLocation { machines in
//            for machine in machines {
//                if machine.status == 2 {
//                    self.status.backgroundColor = UIColor(red:0.95, green:0.74, blue:0.73, alpha:1.0)
//                } else if machine.status == 1 {
//                    self.status.backgroundColor = UIColor(red:1.00, green:0.97, blue:0.73, alpha:1.0)
//                } else {
//                    self.status.backgroundColor = UIColor(red:0.68, green:0.87, blue:0.67, alpha:1.0)
//                }
//
//            }
//        }
//    }
    
    func configure(with laundromat: MachineStruct) {
        nameLabel.text = "machine #\(laundromat.id)"
    }
    
//    private func getMatName(_ name: LaundromatName) -> String {
//        switch name {
//        case .Donlon:
//            return "Donlon"
//        case .Court:
//            return "Court"
//        case .Rose:
//            return "Rose"
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeCollectionViewCell: Timeable {
    func startTimer(duration: Int) {
        timeLabel.text = secString(time: TimeInterval(duration))
        durationVal = getTime(time: TimeInterval(duration))
        isMine = true
    }
    
    func secString(time:TimeInterval) -> String {
        let hours = Int(time)/3600
        let mins = Int(time)/60%60
        let secs = Int(time)%60
        
        return String(format:"%02i:%02i:%02i", hours, mins, secs)
    }
    
    func getTime(time: TimeInterval) -> Int {
        durationVal = Int(time)
        return durationVal
    }
    
    func reportBroken(set: Bool) {
        if set == true {
            status.backgroundColor = UIColor(red:0.95, green:0.74, blue:0.73, alpha:1.0)
            timeLabel.text = ""
        }
    }
    
   
}
