//
//  WeatherInterpreter.swift
//  Hoodie Weather
//
//  Created by Dvontre Coleman on 12/6/18.
//  Copyright © 2018 Dvontre A Coleman. All rights reserved.
//

import Foundation
class WeatherInterpreter{
    
    // Function that recieves the temperature and tells the user the hoodie level
    func hoodieCheck(temp: Int) -> String{
        switch (temp) {
        case -1000...20:
            return "You sure you wanna go out there?"
        case 20...45:
            return "Hoodie and a coat"
        case 45...62:
            return "Hoodie or a coat"
        case 62...70:
            return "Rock The long Sleeve"
        case 70...100:
            return "This is a cold weather app"
        default:
            return "You tell me"
        }
    }
}
