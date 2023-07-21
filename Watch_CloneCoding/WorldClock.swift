//
//  WorldClock.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/13.
//

import Foundation


class WorldClock {
    var translatedName: String
    var name: String
    

    init(translatedName: String, name: String) {
        self.translatedName = translatedName
        self.name = name
    }
    
    func getTimeZone() -> TimeZone? {
        let timeZone = TimeZone(identifier: name)
        return timeZone
    }
}
