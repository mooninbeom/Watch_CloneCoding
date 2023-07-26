//
//  SoundSelectionViewController.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/21.
//

import UIKit
import AudioToolbox

class SoundSelectionViewController: UIViewController {
    let colorSet: UIColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1.0)
    
    var soundList: [String]?
    let soundDir: String = "/System/Library/Audio/UISounds/New"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = self.colorSet
        setUp()
        setUpTable()
        
    }
    
    lazy var soundListTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = self.colorSet
        return view
    }()
    
    

}

extension SoundSelectionViewController {
    private func setUp() {
        
        /*
        self.soundList = FileManager.default.enumerator(atPath: soundDir)?.map{ a in
            String(describing: a)
        }*/
        
        
        self.view.addSubview(self.soundListTableView)
        
        NSLayoutConstraint.activate([
            self.soundListTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.soundListTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.soundListTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            self.soundListTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
    }
}


extension SoundSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    private func setUpTable() {
        self.soundListTableView.dataSource = self
        self.soundListTableView.delegate = self
        self.soundListTableView.register(SoundSelectionCell.self, forCellReuseIdentifier: "soundCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = (self.soundList == nil) ? 1 : self.soundList!.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.soundListTableView.dequeueReusableCell(withIdentifier: "soundCell") as? SoundSelectionCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = (soundList == nil) ? "돌아가기" : soundList![indexPath.row]
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
    }
    
}
