//
//  AlarmHeaderView.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/24.
//

import UIKit

class AlarmHeaderView: UITableViewHeaderFooterView {

    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    var alarmLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "알람"
        view.textColor = .white
        view.textAlignment = .left
        view.font = .systemFont(ofSize: 35, weight: .bold)
        return view
    }()
    
    var sleepLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "🛏️수면 | 기상"
        view.font = .systemFont(ofSize: 20, weight: .bold)
        return view
    }()

    var leftLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "기타"
        view.textColor = .white
        view.font = .systemFont(ofSize: 20, weight: .bold)
        return view
    }()
}

extension AlarmHeaderView{
    private func setUp() {
        contentView.addSubview(alarmLabel)
        alarmLabel.sizeToFit()

        NSLayoutConstraint.activate([
            alarmLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            alarmLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        contentView.addSubview(sleepLabel)
        sleepLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            sleepLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sleepLabel.topAnchor.constraint(equalTo: alarmLabel.bottomAnchor, constant: 30)
        ])
        
        contentView.addSubview(leftLabel)
        leftLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leftLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -10)
        ])
        
        
    }
    
    private func setUpLeft() {
        
    }
}
