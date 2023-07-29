//
//  AddAlarmViewController.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/25.
//

import UIKit

class AddAlarmViewController: UIViewController {
    
    var row: Int?
    var repeatDate: [Bool]?
    var time: [Int] = [0,0]
    var isAdded: Bool = true
    var edittingAlarm: Alarm?
    
    private let selectList: [String] = ["반복", "레이블", "사운드", "다시 알림"]
    private let hour: [Int] = {
        var a: [Int] = []
        for num in 0...23{
            a.append(num)
        }
        return a
    }()
    
    private let minute: [Int] = {
        var a: [Int] = []
        for num in 0...59{
            a.append(num)
        }
        return a
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
        setUpTable()
        setUpPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let editAlarm = self.edittingAlarm {
            self.timePickerView.selectRow(editAlarm.time[0], inComponent: 0, animated: true)
            self.timePickerView.selectRow(editAlarm.time[1], inComponent: 1, animated: true)
            self.time[0] = editAlarm.time[0]
            self.time[1] = editAlarm.time[1]
            self.repeatDate = editAlarm.repeatDate
            self.edittingAlarm = nil
        }
        
        self.optionTableView.reloadData()
    }
    
    lazy var navigationBar: UINavigationBar = {
        let view = UINavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .systemOrange
        view.setBackgroundImage(UIImage(), for: .default)
        view.clipsToBounds = true
        
        let navigationItem = UINavigationItem()
        navigationItem.title = (self.isAdded) ? "알람 추가" : "알람 편집"
        
        let cancelBtn = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelBtnEvent))
        let saveBtn = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveBtnEvent))
        
        navigationItem.rightBarButtonItem = saveBtn
        navigationItem.leftBarButtonItem = cancelBtn
        
        view.setItems([navigationItem], animated: true)
        return view
    }()
    
    lazy var timePickerView: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
    
        return view
    }()
    
    lazy var optionTableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: .insetGrouped)
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .white
        view.isScrollEnabled = false
        view.insetsContentViewsToSafeArea = true
        return view
    }()
    
    lazy var deleteBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("알람 삭제", for: .normal)
        view.setTitleColor(.systemRed, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 15)
        view.isHidden = self.isAdded
        view.backgroundColor = .darkGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.addTarget(self, action: #selector(deleteBtnEvent), for: .touchUpInside)
        return view
    }()
    
}

extension AddAlarmViewController {
    private func setUp() {
//        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        view.addSubview(navigationBar)
        
        NSLayoutConstraint.activate([
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        view.addSubview(timePickerView)
        
        NSLayoutConstraint.activate([
            timePickerView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20),
            timePickerView.heightAnchor.constraint(equalToConstant: screenHeight/4),
            timePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            timePickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        view.addSubview(optionTableView)
        
        NSLayoutConstraint.activate([
            optionTableView.topAnchor.constraint(equalTo: timePickerView.bottomAnchor),
            optionTableView.heightAnchor.constraint(equalTo: timePickerView.heightAnchor, constant: 50),
            optionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            optionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(deleteBtn)
        
        NSLayoutConstraint.activate([
            deleteBtn.leadingAnchor.constraint(equalTo: timePickerView.leadingAnchor),
            deleteBtn.trailingAnchor.constraint(equalTo: timePickerView.trailingAnchor),
            deleteBtn.topAnchor.constraint(equalTo: optionTableView.bottomAnchor),
            deleteBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func getDate(idx: Int) -> String {
        switch idx {
        case 0:
            return "일 "
        case 1:
            return "월 "
        case 2:
            return "화 "
        case 3:
            return "수 "
        case 4:
            return "목 "
        case 5:
            return "금 "
        case 6:
            return "토 "
        default:
            return ""
        }
    }
    
    private func editString(time: Int) -> String {
        if time<10 {
            return "0\(time)"
        } else {
            return String(time)
        }
    }
    
    @objc
    private func cancelBtnEvent() {
        self.dismiss(animated: true)
    }
    
    @objc
    private func saveBtnEvent(_ sender: UIButton!) {
        guard let fourthCell = self.optionTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? AddAlarmCell else {return}
        guard let secondCell = self.optionTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AddAlarmCell else {return}
        guard let firstCell = self.optionTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddAlarmCell else {return}
        
        let isOn = fourthCell.repeatIsOnSwitch.isOn
        let repeatDate = self.repeatDate ?? [false,false,false,false,false,false,false]
        let addAlarm = Alarm(time: self.time, repeatDate: repeatDate, isOn: (self.isAdded) ? true : isOn)
        
        if let cellText = secondCell.textField.text {
            addAlarm.remaind = (cellText.isEmpty) ? nil : cellText
        }
        
        if firstCell.accessoryLabel.text! != "안 함" {
            addAlarm.repeatDateString = firstCell.accessoryLabel.text!
        }
        
        guard let VC1 = self.presentingViewController as? UITabBarController else {return}
        guard let VC2 = VC1.selectedViewController as? AlarmViewController else {return}
        
        VC2.receivedAlarm = addAlarm
        VC2.isEdited = !self.isAdded
        if !self.isAdded {
            VC2.receivedRow = self.row!
        }
        VC2.viewWillAppear(true)
        self.dismiss(animated: true)
    }
    
    @objc
    private func deleteBtnEvent(_ sender: UIButton!) {
        let controller = UIAlertController(title: "경고", message: "정말로 삭제하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default){ _ in
            guard let VC1 = self.presentingViewController as? UITabBarController else {return}
            guard let VC2 = VC1.selectedViewController as? AlarmViewController else {return}
            
            VC2.alarmList.remove(at: self.row!)
            VC2.viewWillAppear(true)
            self.dismiss(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        controller.addAction(ok)
        controller.addAction(cancel)
        self.present(controller, animated: true)
        
        
    }
}

extension AddAlarmViewController: UITableViewDelegate, UITableViewDataSource {
    private func setUpTable() {
        self.optionTableView.delegate = self
        self.optionTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddAlarmCell()
        cell.firstLabel.text = self.selectList[indexPath.row]
        cell.backgroundColor = .darkGray.withAlphaComponent(0.3)
        var inputText = ""
        
        if self.repeatDate != nil {
            for a in 0...6{
                if (self.repeatDate![a]) {
                    inputText.append(self.getDate(idx: a))
                }
            }
        }
        
        if inputText == "월 화 수 목 금 " {
            inputText = "주중"
        } else if inputText == "일 토 " {
            inputText = "주말"
        }
        
        let row = indexPath.row
        switch row {
        case 0:
            cell.accessoryType = .disclosureIndicator
            cell.accessoryLabel.text = (inputText.isEmpty) ? "안 함" : inputText
            cell.labelVisible(row: row)
        case 1:
            cell.labelVisible(row: row)
        case 2:
            cell.accessoryType = .disclosureIndicator
            cell.labelVisible(row: row)
            cell.accessoryLabel.text = "미구현"
        case 3:
            cell.labelVisible(row: row)
        default:
            return cell
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        switch row{
        case 0:
            print("here")
            let VC = RepeatDateSelectionViewController()
            VC.modalPresentationStyle = .automatic
            if let sender = self.repeatDate {
                VC.repeatDate = sender
            }
            self.present(VC, animated: true)
        default:
            break
        }
        self.optionTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension AddAlarmViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    private func setUpPicker() {
        self.timePickerView.delegate = self
        self.timePickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.hour.count
        }
        return self.minute.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0 {
            let result = NSAttributedString(string: String(self.hour[row]), attributes: [.foregroundColor: UIColor.white])
            return result
        }
        let result = NSAttributedString(string: String(self.minute[row]), attributes: [.foregroundColor: UIColor.white])
        return result
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 27))
        
        label.textColor = .white.withAlphaComponent(0.9)
        label.text = (component == 0) ? editString(time: self.hour[row]): editString(time: self.minute[row])
        label.textAlignment = (component == 0) ? .right : .left
        label.font = .systemFont(ofSize: 27)
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 27
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.time[0] = self.hour[row]
        } else {
            self.time[1] = self.minute[row]
        }
        
    }
    
    
}
