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
    private let topItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage()
        self.setUp()
        self.setUpTable()
        alarmList.append(Alarm(time: [11,30], repeatDate: [false], remaind: false, isOn: true))
        alarmList.append(Alarm(time: [11,30], repeatDate: [false], remaind: false, isOn: true))
        alarmList.append(Alarm(time: [11,30], repeatDate: [false], remaind: false, isOn: true))
        alarmList.append(Alarm(time: [11,30], repeatDate: [false], remaind: false, isOn: true))
        alarmList.append(Alarm(time: [11,30], repeatDate: [false], remaind: false, isOn: true))
        alarmList.append(Alarm(time: [11,30], repeatDate: [false], remaind: false, isOn: true))
        alarmList.append(Alarm(time: [11,30], repeatDate: [false], remaind: false, isOn: true))

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if receivedAlarm != nil {
            print("success!")
            receivedAlarm = nil
        }
    }
    
    lazy var navigationBar: UINavigationBar = {
        let view = UINavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .systemOrange
        
        
        let editBtn = UIBarButtonItem(title: "편집", style: .plain, target: self, action: nil)
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addBtnEvent))
        self.topItem.leftBarButtonItem = editBtn
        self.topItem.rightBarButtonItem = addBtn
                
        view.setItems([topItem], animated: true)
        return view
    }()
    
    lazy var alarmTableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorColor = .systemGray
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    
    
}

// MARK: - UI Set Up 메소드
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
    
    @objc
    private func addBtnEvent(_ sender: UIButton!){
        let VC = AddAlarmViewController()
        VC.modalPresentationStyle = .automatic
        self.present(VC, animated: true)
    }
}

// MARK: - TableView 셋업
extension AlarmViewController: UITableViewDelegate, UITableViewDataSource{
    
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
        
        if indexPath.section == 0 {
            cell.firstVisible(isFirst: true)
            return cell
        } else {
            let list = self.alarmList[indexPath.row]
            cell.firstVisible(isFirst: false)
            cell.timeLabel.text = "\(list.time[0]):\(list.time[1])"
            cell.alarmOnOffBtn.isOn = list.isOn
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
    
    
    
}
