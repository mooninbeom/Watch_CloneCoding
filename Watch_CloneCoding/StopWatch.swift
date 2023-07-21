//
//  StopWatch.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/12.
//

import Foundation

class StopWatch {
    public static let shared: StopWatch = StopWatch()
    private init() {}
    
    fileprivate var count: Int = 0
    fileprivate var time: Timer?
    fileprivate var lappedTime: Timer?
    
    func startWatch() -> Void {
//        time = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: <#T##Selector#>, userInfo: nil, repeats: true)
    }
    
    func getCount() -> Int {
        return self.count
    }
    
    func addCount() -> Void {
        self.count += 1
    }
    
    func lap() -> Void {
        self.addCount()
        
    }
    
    func reset() -> Void {
        self.count = 0
    }
    
    @objc
    private func secondTimePrecess(_ sender: Timer!) {
        
    }
}
