//
//  RepeatDateSelectionViewController.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/26.
//

import UIKit

class RepeatDateSelectionViewController: UIViewController {
    
    
    
    let dateList: [String] = ["일요일마다","월요일마다","화요일마다","수요일마다","목요일마다","금요일마다","토요일마다"]
    var repeatDate: [Bool] = [false,false,false,false,false,false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUp()
        setUpTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let VC = self.presentingViewController as? AddAlarmViewController else {return}
        VC.repeatDate = self.repeatDate
        VC.viewWillAppear(true)
    }
    
    lazy var navigationBar: UINavigationBar = {
        let view = UINavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .systemOrange
        view.setBackgroundImage(UIImage(), for: .default)
        view.clipsToBounds = true
        
        let item = UINavigationItem(title: "반복")
        item.leftBarButtonItem = UIBarButtonItem(title: "돌아가기", style: .done, target: self, action: #selector(cancelEvent))
        view.setItems([item], animated: true)
        return view
    }()
    
    lazy var dateTableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: .insetGrouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.allowsMultipleSelection = true
        return view
    }()
}

extension RepeatDateSelectionViewController {
    private func setUp() {
        view.addSubview(navigationBar)
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(dateTableView)
        NSLayoutConstraint.activate([
            dateTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateTableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            dateTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    @objc
    private func cancelEvent() {
        self.dismiss(animated: true)
    }
}

extension RepeatDateSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    private func setUpTable() {
        self.dateTableView.delegate = self
        self.dateTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dateList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = self.dateList[indexPath.row]
        text.textColor = .white
        text.textAlignment = .left
        text.font = .systemFont(ofSize: 17, weight: .bold)
        
        cell.contentView.addSubview(text)
        NSLayoutConstraint.activate([
            text.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            text.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15),
            text.trailingAnchor.constraint(equalTo: cell.contentView.centerXAnchor)
        ])
        cell.accessoryType = (self.repeatDate[indexPath.row]) ? .checkmark : .none
        cell.isSelected = self.repeatDate[indexPath.row]
        if( self.repeatDate[indexPath.row]){
            self.dateTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        cell.tintColor = .systemOrange
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.dateTableView.cellForRow(at: indexPath) else {return}
        cell.accessoryType = .checkmark
        self.repeatDate[indexPath.row] = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = self.dateTableView.cellForRow(at: indexPath) else {return}
        cell.accessoryType = .none
        self.repeatDate[indexPath.row] = false
    }
}

