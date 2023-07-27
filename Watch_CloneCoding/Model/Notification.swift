//
//  Notification.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/22.
//

import UIKit

class Notification {
    private let notiCenter = UNUserNotificationCenter.current()
    private let notiAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
    private var vibration: Vibration = .error
    
    
    init() {
        self.notiCenter.requestAuthorization(options: self.notiAuthOptions) { (success, error) in
            if let error = error {
                print(#function, error)
            }
        }
    }
    
    public func makeNoti(title: String, body: String, userInfo: [ AnyHashable: Any]) {
        let notiContent = UNMutableNotificationContent()
        
        notiContent.badge = 1
        notiContent.title = title
        notiContent.body = body
        notiContent.userInfo = userInfo
        
        self.trigger(identifier: "test", content: notiContent)
    }
    
    private func trigger(identifier: String, content: UNNotificationContent) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        self.notiCenter.add(request){ error in
            if let error = error {
                print(#function, error as Any)
            }
        }
        self.vibration.vibrate()
    }
    
    public func publishAlarm(title: String, body: String, userInfo: [ AnyHashable: Any]) {
        let notiContent = UNMutableNotificationContent()
        
        notiContent.badge = 2
        notiContent.title = title
        notiContent.body = body
        notiContent.userInfo = userInfo
    }
    
    private func alarmTrigger(identifier: String, content: UNNotificationContent, alarm: Alarm) {
        let dateComponents = DateComponents()
        let isNotRepeat = alarm.repeatDate.allSatisfy{ $0 == false }
        
        if isNotRepeat {
            let alarmTime = alarm.time
            
            let nowTime: [Int] = {
                var result: [Int] = []
                let formatter = DateFormatter()
                formatter.dateFormat = "H"
                let hour = formatter.string(from: Date())
                result.append(Int(hour)!)
                
                formatter.dateFormat = "m"
                let min = formatter.string(from: Date())
                result.append(Int(min)!)
                return result
            }()
            
            
            
        }
        
    }
    
    
    
}
