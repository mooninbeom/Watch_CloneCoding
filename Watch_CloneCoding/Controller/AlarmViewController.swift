//
//  AlarmViewController.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/11.
//

import UIKit

class AlarmViewController: UIViewController {
    
    var alarmList: [Alarm] = []
    var receivedAlarm: Alarm?
    var receivedRow: Int?
    var isEdited: Bool = false
    private let topItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage()
        self.setUp()
        self.setUpTable()
        alarmList.append(Alarm(time: [11,30], repeatDate: [false, false, false, true, false, false, false],  isOn: true))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let addAlarm = self.receivedAlarm {
            if self.isEdited {
                self.alarmList[self.receivedRow!] = addAlarm
                receivedRow = nil
            } else {
                self.alarmList.append(addAlarm)
            }
            self.receivedAlarm = nil
        }
        self.sortingAlarm()
        self.alarmTableView.reloadData()
    }
    
    lazy var navigationBar: UINavigationBar = {
        let view = UINavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .systemOrange
        
        
        let editBtn = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(self.editBtnEvent))
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addBtnEvent))
        self.topItem.leftBarButtonItem = editBtn
        self.topItem.rightBarButtonItem = addBtn
                
        view.setItems([topItem], animated: true)
        return view
    }()
    
    lazy var alarmTableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorColor = .darkGray
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    
    
}

// MARK: - UI Set Up 및 버튼 / 정렬 메소드
extension AlarmViewController {
    private func setUp() {
        
        view.addSubview(self.navigationBar)
        view.addSubview(self.alarmTableView)
        NSLayoutConstraint.activate([
            self.navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            self.alarmTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            self.alarmTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.alarmTableView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor),
            self.alarmTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func sortingAlarm() {
        self.alarmList.sort{ (s1, s2) in
            let hour1 = s1.time[0]
            let hour2 = s2.time[0]
            
            if hour1 == hour2 {
                let min1 = s1.time[1]
                let min2 = s2.time[1]
                return min1 < min2
            } else {
                return hour1 < hour2
            }
            
        }
    }
    
    private func editString(time: Int) -> String {
        if time<10 {
            return "0\(time)"
        } else {
            return String(time)
        }
    }
    
    private func editBtnDelegate() {
        for idx in 0..<self.alarmList.count {
            let indexPath = IndexPath(row: idx, section: 1)
            guard let cell = self.alarmTableView.cellForRow(at: indexPath) as? AlarmCell else {return}
            cell.delegate?.beginEditingMode(indexPath: indexPath)
        }
    }
    
    @objc
    private func addBtnEvent(_ sender: UIButton!){
        let VC = AddAlarmViewController()
        VC.modalPresentationStyle = .automatic
        VC.isAdded = true
        self.present(VC, animated: true)
    }
    
    @objc
    private func editBtnEvent(_ sender: UIButton!){
        
        if self.alarmTableView.isEditing {
            self.alarmTableView.setEditing(false, animated: true)
            self.editBtnDelegate()
        } else {
            self.alarmTableView.setEditing(true, animated: true)
            self.editBtnDelegate()
        }
    }
}

// MARK: - TableView 셋업
extension AlarmViewController: UITableViewDelegate, UITableViewDataSource, AlarmCellDelegate{
    
    private func setUpTable() {
        self.alarmTableView.delegate = self
        self.alarmTableView.dataSource = self
        self.alarmTableView.register(AlarmCell.self, forCellReuseIdentifier: "alarmCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.alarmList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.alarmTableView.dequeueReusableCell(withIdentifier: "alarmCell") as? AlarmCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.indexPath = indexPath
        
        if indexPath.section == 0 {
            cell.firstVisible(isFirst: true)
            return cell
        } else {
            let list = self.alarmList[indexPath.row]
            let hour = self.editString(time: list.time[0])
            let min = self.editString(time: list.time[1])
            let intervalText = list.remaind ?? "알람"
            let intervalRepeatText = list.repeatDateString ?? ""
            cell.firstVisible(isFirst: false)
            cell.timeLabel.text = "\(hour):\(min)"
            cell.intervalLabel.text = (intervalRepeatText.isEmpty) ? intervalText : "\(intervalText), \(intervalRepeatText)"
            cell.alarmOnOffBtn.isOn = list.isOn
            cell.timeLabel.textColor = (cell.alarmOnOffBtn.isOn) ? .white : .white.withAlphaComponent(0.5)
            cell.intervalLabel.textColor = (cell.alarmOnOffBtn.isOn) ? .white : .white.withAlphaComponent(0.5)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = AlarmHeaderView()
        if section == 0 {
            header.leftLabel.isHidden = true
            return header
        }
        if section == 1 {
            header.alarmLabel.isHidden = true
            header.sleepLabel.isHidden = true
            return header
        }
        return nil
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 110
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.alarmTableView.deselectRow(at: indexPath, animated: true)
            return
        }
        let sendingAlarm = self.alarmList[indexPath.row]
        
        let VC = AddAlarmViewController()
        VC.isAdded = false
        VC.edittingAlarm = sendingAlarm
        VC.row = indexPath.row
        
        self.present(VC, animated: true)
        
        self.alarmTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if section == 0 {
            self.navigationBar.topItem?.title = "알람"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 0 {
            self.navigationBar.topItem?.title = ""
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteBtn = UIContextualAction(style: .destructive, title: "삭제"){ (_, _, success: @escaping (Bool) -> Void) in
            self.alarmList.remove(at: indexPath.row)
            self.alarmTableView.reloadData()
        }
        let result = UISwipeActionsConfiguration(actions: [deleteBtn])
        return result
    }
    
    func switchOnOff(indexPath: IndexPath) {
        guard let cell = self.alarmTableView.cellForRow(at: indexPath) as? AlarmCell else {return}

        if cell.alarmOnOffBtn.isOn {
            cell.timeLabel.textColor = .white
            cell.intervalLabel.textColor = .white
            self.alarmList[indexPath.row].isOn = true
        } else {
            cell.timeLabel.textColor = .white.withAlphaComponent(0.5)
            cell.intervalLabel.textColor = .white.withAlphaComponent(0.5)
            self.alarmList[indexPath.row].isOn = false
        }
    }
    
    func beginEditingMode(indexPath: IndexPath) {
        guard let cell = self.alarmTableView.cellForRow(at: indexPath) as? AlarmCell else {return}
        if self.alarmTableView.isEditing {
            cell.alarmOnOffBtn.isHidden = true
        } else {
            cell.alarmOnOffBtn.isHidden = false
        }
    }
    
}
