//
//  LocationStruct.swift
//  Laundry_Home
//
//  Created by Sage Lee on 12/2/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import Foundation

struct Location: Codable {
    var id: Int
    var name: String
}

struct LocationData: Codable {
    var data: [Location]
}
