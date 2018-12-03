//
//  TimePickerExt.swift
//  Laundry_Home
//
//  Created by Sage Lee on 11/28/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import Foundation
import UIKit

extension InfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 2
        } else {
            return 59
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;
        
        if (pickerLabel == nil) {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
            pickerLabel?.textAlignment = .center
        }
        
        if component == 0 {
            if hrArray[row] == "1" {
                pickerLabel?.text = String(row) + " hour"
                return pickerLabel!;
            } else {
                pickerLabel?.text = String(row) + " hours"
                return pickerLabel!;
            }
        } else if component == 1 {
            if minArray[row] == "1" {
                pickerLabel?.text = String(row) + " min"
                return pickerLabel!;
            } else {
                pickerLabel?.text = String(row) + " mins"
                return pickerLabel!;
            }
            
        } else {
            if minArray[row] == "1" {
                pickerLabel?.text = String(row) + " sec"
                return pickerLabel!;
            } else {
                pickerLabel?.text = String(row) + " secs"
                return pickerLabel!;
            }
        }
    }
    
}
