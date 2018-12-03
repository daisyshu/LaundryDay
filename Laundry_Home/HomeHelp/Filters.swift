//
//  Filters.swift
//  Laundry_Home
//
//  Created by Sage Lee on 11/30/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import Foundation

enum FilterName: String {
    case washers
    case dryers
}

class Filter {
    var filterVal: FilterName
    
    init(filterVal: FilterName) {
        self.filterVal = filterVal
    }
}
