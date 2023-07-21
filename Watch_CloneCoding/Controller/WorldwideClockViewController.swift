//
//  WorldwideClockViewController.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/11.
//

import UIKit

class WorldwideClockViewController: UIViewController {

    private var worldClockList: [WorldClock] = [WorldClock]()
    private var personalClockList: [WorldClock] = [WorldClock(translatedName: "대한민국", name: "Asia/Seoul")]
    var selectedCity: WorldClock?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let clockRefreshTimer: Timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(clockRefresh), userInfo: nil, repeats: true)
        clockRefreshTimer.fire()
        setUp()
        setTable()
//        self.personalClockList.append(WorldClock(translatedName: "대한민국", name: "Asia/Seoul"))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAddCity()
    }

    lazy var navigationBar: UINavigationBar = {
        let view = UINavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .systemOrange
        let items = UINavigationItem()
        let addBtn = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(goAddView))
        let editBtn = UIBarButtonItem(title: "편집", style: .done, target: self, action: #selector(editTable))
        items.rightBarButtonItem = addBtn
        items.leftBarButtonItem = editBtn
        view.setItems([items], animated: true)
        return view
    }()
    
    lazy var worldClock: UILabel = {
        let view = UILabel()
        view.text = "세계 시계"
        view.textColor = .white
        view.font = .systemFont(ofSize: 45, weight: .bold)
        return view
    }()
    
    lazy var verticalLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return view
    }()
    
    lazy var clockTableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return view
    }()

}

extension WorldwideClockViewController {
    private func setUp() {
        
        self.view.addSubview(self.navigationBar)
        self.navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.navigationBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.view.addSubview(self.clockTableView)
        self.clockTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        self.clockTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        self.clockTableView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor).isActive = true
        self.clockTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func getAddCity() -> Void {
        if selectedCity == nil {return}
        self.personalClockList.append(selectedCity!)
        print(self.selectedCity!.name)
        print(self.selectedCity!.translatedName)
        self.selectedCity = nil
        self.clockTableView.reloadData()
    }
    
    func calcTimeDifference(_ selectedCity: String) -> Int {
        let formatterNow = DateFormatter()
        formatterNow.dateFormat = "HH"
        let a = formatterNow.string(from: Date())
        
        let formatterSelection = DateFormatter()
        formatterSelection.dateFormat = "HH"
        formatterSelection.timeZone = TimeZone(identifier: selectedCity)
        formatterSelection.locale = Locale(identifier: "ko_KR")
        let b = formatterSelection.string(from: Date())
        
        let diff = Int(b)! - Int(a)!
        return diff
        
    }
    
    @objc
    private func goAddView(_ sender: Any) {
        let secondVC = AddCityViewController()
        secondVC.wholeCityList = self.worldClockList
        let navCon = UINavigationController(rootViewController: secondVC)
        
        self.present(navCon, animated: true)
    }
    
    @objc
    private func editTable(_ sender: UIBarButtonItem) {
        let shouldBeEdited = !self.clockTableView.isEditing
        self.clockTableView.setEditing(shouldBeEdited, animated: true)
//        sender.isSelected = shouldBeEdited
        if (self.clockTableView.isEditing) {
            sender.title = "완료"
        } else {
            sender.title = "편집"
        }
    }
    
    @objc
    private func clockRefresh() -> Void {
        self.clockTableView.reloadData()
    }
}

extension WorldwideClockViewController: UITableViewDelegate, UITableViewDataSource {
    func setTable() {
        self.clockTableView.dataSource = self
        self.clockTableView.delegate = self
        self.clockTableView.register(WorldWideCell.self, forCellReuseIdentifier: "worldCell")
        self.clockTableView.register(WorldWideClockHeaderView.self, forHeaderFooterViewReuseIdentifier: "worldHeader")
        self.clockTableView.separatorColor = .darkGray
        
        
        if self.worldClockList.isEmpty{
            for tz in TimeZone.knownTimeZoneIdentifiers{
                let timeZone = TimeZone(identifier: tz)
                let translatedName: String = timeZone?.localizedName(for: NSTimeZone.NameStyle.shortGeneric, locale: Locale(identifier: "ko_KR")) ?? "fail"
                let test = translatedName.split(separator: " ")
                var a = ""
                for i in test {
                    if(String(i) == "시간") {
                        break
                    }
                    a.append(String(i))
                }
                let add = WorldClock(translatedName: a, name: tz)
                self.worldClockList.append(add)
            }
        }
        
    }
    
    func getTimeZoneList() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personalClockList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.clockTableView.dequeueReusableCell(withIdentifier: "worldCell") as? WorldWideCell else {return UITableViewCell()}
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: self.personalClockList[indexPath.row].name)
        formatter.dateFormat = "HH:mm"
        
        let diff = self.calcTimeDifference(self.personalClockList[indexPath.row].name)
        let dateLabelText: String = (diff >= 0) ? "+\(diff)시간" : "\(diff)시간"
        
        cell.overrideUserInterfaceStyle = .dark
        cell.dateLabel.text = "오늘, \(dateLabelText)"
        cell.regionLabel.text = self.personalClockList[indexPath.row].translatedName
        cell.timeLabel.text = formatter.string(from: Date())
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = self.clockTableView.dequeueReusableHeaderFooterView(withIdentifier: "worldHeader") as? WorldWideClockHeaderView else {return UITableViewHeaderFooterView()}
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.clockTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") {(_,_, success: @escaping (Bool) -> Void) in
            print("touched!")
            self.personalClockList.remove(at: indexPath.row)
            self.clockTableView.reloadData()
            success(true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveData = self.personalClockList[sourceIndexPath.row]
        let count = destinationIndexPath.row - sourceIndexPath.row
        
        if count > 0 {
            self.personalClockList.insert(moveData, at: destinationIndexPath.row+1)
            self.personalClockList.remove(at: sourceIndexPath.row)
        } else if count < 0 {
            self.personalClockList.insert(moveData, at: destinationIndexPath.row)
            let removeIndex = self.personalClockList.lastIndex{ a in
                a.name == moveData.name && a.translatedName == moveData.translatedName
            }
            self.personalClockList.remove(at: removeIndex!)
        }
        self.clockTableView.reloadData()
        
    }
}
