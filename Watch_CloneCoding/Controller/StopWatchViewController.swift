//
//  StopWatchViewController.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/11.
//

import UIKit

class StopWatchViewController: UIViewController {
    
    fileprivate var timer: Timer?
    fileprivate var lappedTimer: Timer?
    fileprivate var countTimeList: Int = 0
    fileprivate var lapCountTime: Int = 0
    fileprivate var countTime: Int = 0
    fileprivate var lapCount: [Int] = [Int]()
    fileprivate var isStarted: Bool = false
    fileprivate var teststr: String?
    fileprivate var lapList: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setExtension()
        
        
    }
    
    // 중앙 시간 Label
    lazy var timerLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "00:00.00"
        view.font = .monospacedDigitSystemFont(ofSize: 90, weight: UIFont.Weight.thin)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    // lap 및 리셋 버튼
    lazy var lapBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("랩", for: .normal)
        view.setTitleColor(.systemGray, for: .normal)
        view.backgroundColor = .darkGray.withAlphaComponent(0.35)
        view.addTarget(self, action: #selector(lapping), for: .touchUpInside)
        return view
    }()
    
    // 시작 버튼
    lazy var startBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("시작", for: .normal)
        view.setTitle("중단", for: .selected)
        view.setTitleColor(.systemGreen, for: .normal)
        view.setTitleColor(.systemRed, for: .selected)
        view.backgroundColor = .systemGreen.withAlphaComponent(0.2)
        view.addTarget(self, action: #selector(startWatch), for: .touchUpInside)
        return view
    }()
    
    lazy var lapTable: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    var verticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var darkCircle: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

}

extension StopWatchViewController {
    func setUp() {
        
        self.view.backgroundColor = .black
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        let safeConstant: CGFloat = 10
        
        let buttonWidth = (screenWidth-2*safeConstant)/5
        
        self.view.addSubview(timerLabel)
        self.timerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: safeConstant).isActive = true
        self.timerLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -safeConstant).isActive = true
        self.timerLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.timerLabel.bottomAnchor.constraint(equalTo: self.timerLabel.topAnchor, constant: screenHeight/3).isActive = true
        
        self.view.addSubview(lapBtn)
        self.lapBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: safeConstant).isActive = true
        self.lapBtn.trailingAnchor.constraint(equalTo: self.lapBtn.leadingAnchor, constant: buttonWidth).isActive = true
        self.lapBtn.topAnchor.constraint(equalTo: self.timerLabel.bottomAnchor).isActive = true
        self.lapBtn.bottomAnchor.constraint(equalTo: self.lapBtn.topAnchor, constant: buttonWidth).isActive = true
        self.lapBtn.layer.cornerRadius = buttonWidth/2.0
        self.lapBtn.clipsToBounds = true
        
        /*
        self.view.addSubview(darkCircle)
        self.darkCircle.centerXAnchor.constraint(equalTo: self.lapBtn.centerXAnchor).isActive = true
        self.darkCircle.centerYAnchor.constraint(equalTo: self.lapBtn.centerYAnchor).isActive = true
        self.darkCircle.widthAnchor.constraint(equalToConstant: buttonWidth-10).isActive = true
        self.darkCircle.heightAnchor.constraint(equalToConstant: buttonWidth-10).isActive = true
        self.darkCircle.layer.cornerRadius = (buttonWidth-10)/2.0
        self.darkCircle.clipsToBounds = true
         */
        
        self.view.addSubview(startBtn)
        self.startBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -safeConstant).isActive = true
        self.startBtn.leadingAnchor.constraint(equalTo: self.startBtn.trailingAnchor, constant: -buttonWidth).isActive = true
        self.startBtn.topAnchor.constraint(equalTo: self.timerLabel.bottomAnchor).isActive = true
        self.startBtn.bottomAnchor.constraint(equalTo: self.startBtn.topAnchor, constant: buttonWidth).isActive = true
        self.startBtn.layer.cornerRadius = buttonWidth/2.0
        self.startBtn.clipsToBounds = true
        
        self.view.addSubview(verticalLine)
        self.verticalLine.widthAnchor.constraint(equalToConstant: screenWidth - safeConstant*2).isActive = true
        self.verticalLine.heightAnchor.constraint(equalToConstant: 0.4).isActive = true
        self.verticalLine.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.verticalLine.topAnchor.constraint(equalTo: self.startBtn.bottomAnchor, constant: safeConstant*2).isActive = true
        
        self.view.addSubview(lapTable)
        self.lapTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: safeConstant).isActive = true
        self.lapTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -safeConstant).isActive = true
        self.lapTable.topAnchor.constraint(equalTo: self.verticalLine.bottomAnchor).isActive = true
        self.lapTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    
    
    @objc
    private func startWatch(_ sender: UIButton!) {

        if !sender.isSelected {
            if(lapList.isEmpty){
                lapList.append("!")
                lapCount.append(1)
            }
            setTimer()
            startBtn.backgroundColor = .systemRed.withAlphaComponent(0.2)
            startBtn.isSelected = true
            lapBtn.setTitle("랩", for: .normal)
            lapBtn.setTitleColor(.white, for: .normal)
            lapBtn.backgroundColor = .darkGray.withAlphaComponent(0.7)
        } else {
            timer!.invalidate()
            lappedTimer!.invalidate()
            startBtn.backgroundColor = .systemGreen.withAlphaComponent(0.2)
            startBtn.isSelected = false
            lapBtn.setTitle("재설정", for: .normal)
        }
    }
    
    @objc
    private func lapping(_ sender: UIButton!) {
        if !startBtn.isSelected && !lapList.isEmpty {
            self.timer = nil
            self.lappedTimer = nil
            teststr = nil
            countTime = 0
            countTimeList = 0
            lapCountTime = 0
            lapCount = [Int]()
            lapList = [String]()
            lapBtn.setTitle("랩", for: .normal)
            lapBtn.setTitleColor(.systemGray, for: .normal)
            lapBtn.backgroundColor = .darkGray.withAlphaComponent(0.35)
            self.timerLabel.text = "00:00.00"
            self.lapTable.reloadData()
            return
        }
        self.lapCount.reverse()
        self.lapList.reverse()
        self.lapList[lapList.endIndex-1] = self.teststr!
        self.lapCount.append(lapList.count+1)
        self.lapList.append("!")
        
        self.lapCount.reverse()
        self.lapList.reverse()
        self.lapCountTime = 0
        self.lapTable.reloadData()
    }
}

extension StopWatchViewController {

    func setTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(secondTimeProcess), userInfo: nil, repeats: true)
        timer = Timer(timeInterval: 0.01, target: self, selector: #selector(self.secondTimeProcess), userInfo: nil, repeats: true)
        lappedTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.lapSecondTimeProcess), userInfo: nil, repeats: true)
//        RunLoop.main.add(timer!, forMode: .common)
//        RunLoop.main.add(lappedTimer!, forMode: .common)
//        RunLoop.current.add(timer!, forMode: .common)
        RunLoop.current.add(lappedTimer!, forMode: .common)
        
        
        DispatchQueue.global(qos:.userInteractive).async {
            let runLoop = RunLoop.current
            runLoop.add(self.timer!, forMode: .default)
            runLoop.run()
        }
         
//        RunLoop.main.add(lappedTimer!, forMode: .common)
    }
    
    func makeTimeLabel(_ time: Int) -> String {
        let second = time % 100
        let minute = time / 100 % 60
        let hour = time / 100 / 60
        
        let secondStr = (second<10) ? "0\(second)" : "\(second)"
        let minuteStr = (minute<10) ? "0\(minute)" : "\(minute)"
        let hourStr = (hour<10) ? "0\(hour)" : "\(hour)"
        
        return "\(hourStr):\(minuteStr).\(secondStr)"
        
    }
    
//    func findMinMaxLap() -> [String.Index]{
//        
//    }
    
    @objc
    func secondTimeProcess(_ sender: Timer!) {
        self.countTime += 1
        DispatchQueue.main.async {
            self.timerLabel.text = self.makeTimeLabel( self.countTime )
        }
    }
    
    @objc
    func lapSecondTimeProcess(_ sender: Timer!) {
        self.lapCountTime += 1
        self.teststr = self.makeTimeLabel(self.lapCountTime)
        self.lapTable.reloadData()
    }
}

extension StopWatchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setExtension() {
        self.lapTable.delegate = self
        self.lapTable.dataSource = self
        self.lapTable.register(StopWatchCell.self, forCellReuseIdentifier: "cell")
        self.lapTable.separatorColor = .systemGray
        self.lapTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
     }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lapList.count
     }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.lapTable.dequeueReusableCell(withIdentifier: "cell") as? StopWatchCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.lapCountLabel.text = "랩 \(lapCount[indexPath.row])"
        cell.timeLabel.text = (lapList[indexPath.row] == "!") ? teststr : lapList[indexPath.row]
        return cell
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.lapTable.deselectRow(at: indexPath, animated: false)
    }
 }



