//
//  TempLaundromat.swift
//  Laundry_Home
//
//  Created by Sage Lee on 11/27/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import Foundation
import UIKit

enum LaundromatName: String {
    case Donlon
    case Court
    case Rose
}

class TempLaundromat {
    var name: LaundromatName
    
    init(name: LaundromatName) {
        self.name = name
    }
}
