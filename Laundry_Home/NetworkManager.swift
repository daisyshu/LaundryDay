//
//  NetworkManager.swift
//  Laundry_Home
//
//  Created by Sage Lee on 12/2/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static let locationEndpoint = "http://35.243.195.34/api/locations/"
    private static let hr5Endpoint = "http://35.243.195.34/api/locations/2/machines/"
    private static let timeStartEndpoint = "http://35.243.195.34/api/machines/1/start/"
    
    static func getLocations(completion: @escaping ([Location]) -> Void) {
        Alamofire.request(locationEndpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                    print(json)
                }
                let decoder = JSONDecoder()
                if let location = try? decoder.decode(LocationData.self, from: data) {
                    completion(location.data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getMachinesinLocation(completion: @escaping ([MachineStruct]) -> Void) {
        Alamofire.request(hr5Endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let decoder = JSONDecoder()
                if let machines = try? decoder.decode(MachineData.self, from: data) {
                    completion(machines.data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func postTimerDuration(duration: Int, completion: @escaping (MachineStruct) -> Void) {
        let parameters: [String:Any] = [
            "duration": duration
        ]
        Alamofire.request(timeStartEndpoint, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let decoder = JSONDecoder()
                if let timer = try? decoder.decode(MachineStruct.self, from: data) {
                    print(timer)
                    completion(timer)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
//    static func getLocId(fromLocation location: Location, didGetLocation: @escaping ([Location]) -> Void) {
//        let parameters =
//        [
//            "location": location
//        ]
//        Alamofire.request(locationEndpoint, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: nil).validate().responseData{ (response) in
//            switch response.result {
//            case .success(let data):
//                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
//                    print(json)
//                }
//                let decoder = JSONDecoder()
//                if let location = try? decoder.decode(LocationData.self, from: data) {
//                    didGetLocation(location.data)
//                } else {
//                    print("invalid data")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//
//        }
//    }
}
