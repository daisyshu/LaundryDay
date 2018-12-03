//
//  MachineStruct.swift
//  Laundry_Home
//
//  Created by Sage Lee on 12/2/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import Foundation

struct MachineStruct: Codable {
    var id: Int
    var location: Int
    var washer: Bool
    var status: Int
    var time_remaining: Int
}

struct MachineData: Codable {
    var data: [MachineStruct]
}
