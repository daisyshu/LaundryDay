//
//  TimePicker.swift
//  Laundry_Home
//
//  Created by Sage Lee on 11/28/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

class TimePicker: UIPickerView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
