//
//  Machine.swift
//  Laundry_Home
//
//  Created by Sage Lee on 12/1/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import Foundation

enum StatusValue: String {
    case green
    case yellow
    case red
}

class Machine {
    var name: String
    var status: StatusValue
    
    init(name: String, status: StatusValue) {
        self.name = name
        self.status = status
    }
}

