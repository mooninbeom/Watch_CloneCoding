//
//  TimerViewController.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/11.
//

import UIKit

class TimerViewController: UIViewController {
    let colorSet: UIColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1.0)
    let test1 = ["1","2","3","4","5"]
    let test2 = ["one","two","three","four","five"]
    let constText = ["시간", "분", "초"]
    
    var timerIsStarted: Bool = false
    var selectedHour: Int = 0
    var selectedMin: Int = 0
    var selectedSec: Int = 0
    var remainedStrokeEnd: CGFloat = 1
    var timer: Timer?
    var remainingTime: Int?
    var realTime: Int?
    
    
    
    var remainingLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "00"
        view.textColor = .white
        view.font = .monospacedDigitSystemFont(ofSize: 70, weight: .thin)
//        view.font = .systemFont(ofSize: 70, weight: .thin)
        return view
    }()
    
    var whenAlarmedLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    var timerAnimation: CABasicAnimation = {
        let anime = CABasicAnimation(keyPath: "strokeEnd")
        anime.toValue = 0
        anime.isRemovedOnCompletion = false
        anime.fillMode = .forwards
        return anime
    }()
    
    let hourSet: [String] = {
        var a: [String] = []
        for num in 0...23 {
            a.append(String(num))
        }
        return a
    }()
    let minuteSet: [String] = {
        var a: [String] = []
        for num in 0...59 {
            a.append(String(num))
        }
        return a
    }()
    let secondSet: [String] = {
        var a: [String] = []
        for num in 0...59 {
            a.append(String(num))
        }
        return a
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setUp()
        setPickerView()
        
    }
    
    
    
    lazy var timePicker: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    
    lazy var baseCircularIndicator: CAShapeLayer = {
        let view = CAShapeLayer()
        return view
    }()
    
    lazy var nowCircularIndicator: CAShapeLayer = {
        let view = CAShapeLayer()
        return view
    }()
    
    lazy var cancelBtnBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray.withAlphaComponent(0.35)
        return view
    }()
    
    lazy var cancelBtnRingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    lazy var cancelBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("취소", for: .normal)
        view.setTitleColor(.darkGray, for: .normal)
        view.backgroundColor = .darkGray.withAlphaComponent(0.35)
        
        view.addTarget(self, action: #selector(cancelBtnEvent), for: .touchUpInside)
        return view
    }()
    
    lazy var startBtnBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGreen.withAlphaComponent(0.2)
        return view
    }()
    
    lazy var startBtnRingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    lazy var startBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("시작", for: .normal)
        view.setTitleColor(.systemGreen, for: .normal)
        view.backgroundColor = .systemGreen.withAlphaComponent(0.2)
        
        view.addTarget(self, action: #selector(startBtnEvent), for: .touchUpInside)
        return view
    }()
    
    lazy var soundSelectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = self.colorSet
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    var hourLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "시간"
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textColor = .white
        view.sizeToFit()
        return view
    }()
    
    var minLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "분"
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textColor = .white
        view.sizeToFit()
        return view
    }()
    
    var secLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "초"
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textColor = .white
        view.sizeToFit()
        return view
    }()
    
    
}

// MARK: - UI Set Up
extension TimerViewController {
    private func setUp() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let safeConstant: CGFloat = 10
        let buttonSize = (screenWidth - safeConstant*2) / 5
        let ringSize = buttonSize - 5
        let clickSize = ringSize - 5
        let labelConstant: CGFloat = (screenWidth - 20) / 6
        let window = UIApplication.shared.windows.first
        let top = window?.safeAreaInsets.top
        
        
        self.view.addSubview(self.timePicker)
        self.timePicker.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.timePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.timePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        self.timePicker.bottomAnchor.constraint(equalTo: self.timePicker.topAnchor, constant: screenHeight/3).isActive = true
        
        
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: screenWidth/2.0, y:  top! + screenHeight/6), radius: (screenWidth-80)/2.0, startAngle: CGFloat(-0.5*Double.pi), endAngle: CGFloat(1.5*Double.pi), clockwise: true)
        self.baseCircularIndicator.path = circlePath.cgPath
        self.baseCircularIndicator.fillColor = UIColor.clear.cgColor
        self.baseCircularIndicator.strokeColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
        self.baseCircularIndicator.lineWidth = 7
        view.layer.addSublayer(baseCircularIndicator)
        self.baseCircularIndicator.isHidden = true
        
        
        
        let circlePath2 = UIBezierPath(arcCenter: CGPoint(x: screenWidth/2.0, y:  top! + screenHeight/6), radius: (screenWidth-80)/2.0, startAngle: CGFloat(-0.5*Double.pi), endAngle: CGFloat(1.5*Double.pi), clockwise: true)
        self.nowCircularIndicator.path = circlePath2.cgPath
        self.nowCircularIndicator.lineCap = .round
        self.nowCircularIndicator.fillColor = UIColor.clear.cgColor
        self.nowCircularIndicator.strokeColor = UIColor.systemOrange.cgColor
        self.nowCircularIndicator.lineWidth = 7
        self.nowCircularIndicator.strokeEnd = 1
        self.view.layer.addSublayer(self.nowCircularIndicator)
        self.nowCircularIndicator.isHidden = true
        
       
        self.view.addSubview(self.remainingLabel)
        remainingLabel.centerXAnchor.constraint(equalTo: self.timePicker.centerXAnchor, constant: 10).isActive = true
        remainingLabel.centerYAnchor.constraint(equalTo: self.timePicker.centerYAnchor, constant: -10).isActive = true
        self.remainingLabel.isHidden = true
        
        self.view.addSubview(self.whenAlarmedLabel)
        self.whenAlarmedLabel.centerXAnchor.constraint(equalTo: self.remainingLabel.centerXAnchor).isActive = true
        self.whenAlarmedLabel.centerYAnchor.constraint(equalTo: self.timePicker.centerYAnchor, constant: 60).isActive = true
        self.whenAlarmedLabel.isHidden = true

        
        
        

        
        self.view.addSubview(hourLabel)
        self.hourLabel.centerXAnchor.constraint(equalTo: self.timePicker.leadingAnchor, constant: labelConstant+35).isActive = true
        self.hourLabel.centerYAnchor.constraint(equalTo: self.timePicker.centerYAnchor).isActive = true
        
        self.view.addSubview(minLabel)
        self.minLabel.centerXAnchor.constraint(equalTo: self.timePicker.leadingAnchor, constant: labelConstant*3+15).isActive = true
        self.minLabel.centerYAnchor.constraint(equalTo: self.timePicker.centerYAnchor).isActive = true
        
        self.view.addSubview(secLabel)
        self.secLabel.centerXAnchor.constraint(equalTo: self.timePicker.leadingAnchor, constant: labelConstant*5+5).isActive = true
        self.secLabel.centerYAnchor.constraint(equalTo: self.timePicker.centerYAnchor).isActive = true
        
        self.view.addSubview(self.cancelBtnBaseView)
        self.cancelBtnBaseView.topAnchor.constraint(equalTo: self.timePicker.bottomAnchor).isActive = true
        self.cancelBtnBaseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: safeConstant).isActive = true
        self.cancelBtnBaseView.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        self.cancelBtnBaseView.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        self.cancelBtnBaseView.layer.cornerRadius = buttonSize/2.0
        self.cancelBtnBaseView.clipsToBounds = true
        
        self.view.addSubview(self.cancelBtnRingView)
        self.cancelBtnRingView.centerXAnchor.constraint(equalTo: self.cancelBtnBaseView.centerXAnchor).isActive = true
        self.cancelBtnRingView.centerYAnchor.constraint(equalTo: self.cancelBtnBaseView.centerYAnchor).isActive = true
        self.cancelBtnRingView.heightAnchor.constraint(equalToConstant: ringSize).isActive = true
        self.cancelBtnRingView.widthAnchor.constraint(equalToConstant: ringSize).isActive = true
        self.cancelBtnRingView.layer.cornerRadius = ringSize/2.0
        self.cancelBtnRingView.clipsToBounds = true
        
        self.view.addSubview(self.cancelBtn)
        self.cancelBtn.centerXAnchor.constraint(equalTo: self.cancelBtnBaseView.centerXAnchor).isActive = true
        self.cancelBtn.centerYAnchor.constraint(equalTo: self.cancelBtnBaseView.centerYAnchor).isActive = true
        self.cancelBtn.widthAnchor.constraint(equalToConstant: clickSize).isActive = true
        self.cancelBtn.heightAnchor.constraint(equalToConstant: clickSize).isActive = true
        self.cancelBtn.layer.cornerRadius = clickSize / 2.0
        self.cancelBtn.clipsToBounds = true
        
        self.view.addSubview(self.startBtnBaseView)
        self.startBtnBaseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.startBtnBaseView.topAnchor.constraint(equalTo: self.cancelBtnBaseView.topAnchor).isActive = true
        self.startBtnBaseView.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        self.startBtnBaseView.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        self.startBtnBaseView.layer.cornerRadius = buttonSize / 2.0
        self.startBtnBaseView.clipsToBounds = true
        
        self.view.addSubview(self.startBtnRingView)
        self.startBtnRingView.centerXAnchor.constraint(equalTo: self.startBtnBaseView.centerXAnchor).isActive = true
        self.startBtnRingView.centerYAnchor.constraint(equalTo: self.startBtnBaseView.centerYAnchor).isActive = true
        self.startBtnRingView.widthAnchor.constraint(equalToConstant: ringSize).isActive = true
        self.startBtnRingView.heightAnchor.constraint(equalToConstant: ringSize).isActive = true
        self.startBtnRingView.layer.cornerRadius = ringSize / 2.0
        self.startBtnRingView.clipsToBounds = true
        
        self.view.addSubview(self.startBtn)
        self.startBtn.centerXAnchor.constraint(equalTo: self.startBtnBaseView.centerXAnchor).isActive = true
        self.startBtn.centerYAnchor.constraint(equalTo: self.startBtnBaseView.centerYAnchor).isActive = true
        self.startBtn.widthAnchor.constraint(equalToConstant: clickSize).isActive = true
        self.startBtn.heightAnchor.constraint(equalToConstant: clickSize).isActive = true
        self.startBtn.layer.cornerRadius = clickSize / 2.0
        self.startBtn.clipsToBounds = true
        
        self.view.addSubview(self.soundSelectionView)
        self.soundSelectionView.topAnchor.constraint(equalTo: self.cancelBtn.bottomAnchor, constant: 30).isActive = true
        self.soundSelectionView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        self.soundSelectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: safeConstant).isActive = true
        self.soundSelectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -safeConstant).isActive = true
        
        self.timePicker.overrideUserInterfaceStyle = .dark
        
        
        
        
        self.view.addSubview(self.soundSelectionView)
        
    }
    
    
    
    
}

// MARK: - Button Event

extension TimerViewController {
    
    @objc // startBtn을 터치 했을 때
    private func startBtnEvent(_ sender: UIButton!) -> Void {
        if (self.selectedHour == 0 && self.selectedMin == 0 && self.selectedSec == 0) {
            return
        }
        if !timerIsStarted {
            self.cancelBtn.setTitleColor(.white, for: .normal)
            
            self.startBtn.backgroundColor = .systemOrange.withAlphaComponent(0.2)
            self.startBtnBaseView.backgroundColor = .systemOrange.withAlphaComponent(0.2)
            self.startBtn.setTitle("일시 정지", for: .normal)
            self.startBtn.setTitleColor(.systemOrange, for: .normal)
            self.startBtn.titleLabel?.font = .systemFont(ofSize: 14)
            sender.isSelected = false
            timerIsStarted = true
            self.changeViewToCircle(true)
            let totalDuration: Double = Double(self.selectedHour*3600) + Double(self.selectedMin*60) + Double(self.selectedSec)
            self.realTime = (self.selectedHour*3600 + self.selectedMin*60 + self.selectedSec)*100
            self.timerStarted(duration: totalDuration)
        } else {
            if sender.isSelected {
                self.startBtn.backgroundColor = .systemOrange.withAlphaComponent(0.2)
                self.startBtnBaseView.backgroundColor = .systemOrange.withAlphaComponent(0.2)
                self.startBtn.setTitle("일시 정지", for: .normal)
                self.startBtn.setTitleColor(.systemOrange, for: .normal)
                self.startBtn.titleLabel?.font = .systemFont(ofSize: 14)
                self.startBtn.isSelected = false
                self.timerRestarted()
            } else {
                self.startBtn.backgroundColor = .systemGreen.withAlphaComponent(0.2)
                self.startBtnBaseView.backgroundColor = .systemGreen.withAlphaComponent(0.2)
                self.startBtn.setTitle("재개", for: .normal)
                self.startBtn.setTitleColor(.systemGreen, for: .normal)
                self.startBtn.titleLabel?.font = .systemFont(ofSize: 18)
                self.startBtn.isSelected = true
                self.timerStopped()
            }
        }
    }
    
    
    @objc // cancelBtn 을 터치 했을 때
    private func cancelBtnEvent(_ sender: UIButton!) -> Void {
        if timerIsStarted {
            self.cancelBtn.setTitleColor(.darkGray, for: .normal)
            
            self.startBtn.isSelected = false
            self.startBtn.setTitle("시작", for: .normal)
            self.startBtn.setTitleColor(.systemGreen, for: .normal)
            self.startBtn.backgroundColor = .systemGreen.withAlphaComponent(0.2)
            self.startBtnBaseView.backgroundColor = .systemGreen.withAlphaComponent(0.2)
            
            self.timer?.invalidate()
            self.timer = nil
            self.remainingTime = nil
            self.realTime = nil
            
            self.changeViewToCircle(false)
        }
        self.startBtn.titleLabel?.font = .systemFont(ofSize: 18)
        self.timerIsStarted = false
    }
}




// MARK: - Timer Event 메소드
extension TimerViewController {
    
    // 타이머가 시작되었을 때
    private func timerStarted(duration: TimeInterval) {
        self.timer?.invalidate()
        
        self.remainingTime = Int(duration)
        self.remainingLabel.text = self.makeTimeLabelToGood(self.remainingTime!)
        whenTimerAlarmed()

        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ _ in
            if self.realTime! == 0 {
                return
            }
            self.realTime! -= 1
            if (self.realTime! % 100 == 0) {
                self.remainingLabel.text = self.makeTimeLabelToGood(self.realTime!/100)
            }
            
        }
        
        self.timerAnimation.duration = duration
        self.nowCircularIndicator.add(self.timerAnimation, forKey: "test")
    }
    
    // 타이머가 멈췄을 때
    private func timerStopped() {
        self.timer?.invalidate()
        let offsetTime = self.view.layer.convertTime(CACurrentMediaTime(), from: nil)
        self.view.layer.speed = 0
        self.view.layer.timeOffset = offsetTime
    }
    
    // 타이머가 다시 시작될 때
    private func timerRestarted() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ _ in
            if self.realTime! == 0 {
                return
            }
            print(self.realTime!)
            self.realTime! -= 1
            if (self.realTime! % 100 == 0) {
                self.remainingLabel.text = self.makeTimeLabelToGood(self.realTime!/100)
            }
            
        }
        let pausedTime = self.view.layer.timeOffset
        self.view.layer.speed = 1.0
        self.view.layer.timeOffset = 0.0
        self.view.layer.beginTime = 0.0
        
        let timeSincePaused = self.view.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        print(timeSincePaused)
        self.view.layer.beginTime = timeSincePaused
    }
    
    // 남은 시간을 "00:00:00" String 으로 바꿔주는 메소드
    private func makeTimeLabelToGood(_ time: Int) -> String {
        let hour = time / 3600
        if hour == 0 {
            let minute = time / 60
            let second = time % 60
            
            let minuteString = (minute<10) ? "0\(minute)" : "\(minute)"
            let secondString = (second<10) ? "0\(second)" : "\(second)"
            
            let resultString = "\(minuteString):\(secondString)"
            return resultString
        } else {
            let minute = time % 3600 / 60
            let second = time % 3600 % 60
            
            let hourString = (hour<10) ? "0\(hour)" : "\(hour)"
            let minuteString = (minute<10) ? "0\(minute)" : "\(minute)"
            let secondString = (second<10) ? "0\(second)" : "\(second)"
            
            let resultString = "\(hourString):\(minuteString):\(secondString)"
            return resultString
        }
    }
    
    // 타이머가 언제 끝날 지 알려주는 메소드
    private func whenTimerAlarmed() {
        let nowDate = Date()
        let resultDate = nowDate.addingTimeInterval(Double(self.remainingTime!))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let result = formatter.string(from: resultDate)
        self.whenAlarmedLabel.text = "\(result)"
        
    }
    
    // 타이머가 시작되거나 끝날 때 View를 바꿔주는 메소드
    private func changeViewToCircle(_ changeView: Bool) -> Void {
        self.hourLabel.isHidden = changeView
        self.minLabel.isHidden = changeView
        self.secLabel.isHidden = changeView
        self.timePicker.isHidden = changeView
        
        self.baseCircularIndicator.isHidden = !changeView
        self.nowCircularIndicator.isHidden = !changeView
        self.remainingLabel.isHidden = !changeView
        self.whenAlarmedLabel.isHidden = !changeView
    }
}




// MARK: - UIPickerView Extension
extension TimerViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func setPickerView() {
        self.timePicker.delegate = self
        self.timePicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return self.hourSet.count
        case 1:
            return self.minuteSet.count
        case 2:
            return self.secondSet.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch component {
        case 0:
            return NSAttributedString(string: self.hourSet[row], attributes: [.foregroundColor: UIColor.systemGray])
        case 1:
            return NSAttributedString(string: self.minuteSet[row], attributes: [.foregroundColor: UIColor.systemGray])
        case 2:
            return NSAttributedString(string: self.secondSet[row], attributes: [.foregroundColor: UIColor.systemGray])
        default:
            return NSAttributedString(string: self.test1[row], attributes: [.foregroundColor: UIColor.white])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 33, height: 25))
        label.textColor = .systemGray
        label.textAlignment = .right
        label.font = .monospacedDigitSystemFont(ofSize: 25, weight: .regular)
        label.textAlignment = .right
        
        if component == 0 {
            label.text = hourSet[row]
            return label
        } else if component == 1 {
            label.text = minuteSet[row]
            return label
        } else {
            label.text = secondSet[row]
            return label
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            self.selectedHour = Int(hourSet[row])!
        }
        if (component == 1) {
            self.selectedMin = Int(minuteSet[row])!
        }
        if (component == 2) {
            self.selectedSec = Int(secondSet[row])!
        }
    }
}


