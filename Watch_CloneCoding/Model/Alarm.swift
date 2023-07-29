//
//  Alarm.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/25.
//

import Foundation


class Alarm {
    var time: [Int]
    var repeatDate: [Bool] = [false, false, false, false, false, false, false]
    var sound: String?
    var remaind: String?
    var repeatDateString: String?
    var isOn: Bool
    
    init(time: [Int], repeatDate: [Bool], isOn: Bool) {
        self.time = time
        self.repeatDate = repeatDate
        self.isOn = isOn
    }
    
}
