//
//  AlarmCell.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/24.
//

import UIKit



class AlarmCell: UITableViewCell {
    
    var delegate: AlarmCellDelegate?
    var indexPath: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .black
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var timeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.text = "12:34"
        view.font = .systemFont(ofSize: 60, weight: .light)
        view.sizeToFit()
        return view
    }()
    
    var intervalLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .systemFont(ofSize: 14)
        view.text = "알람"
        return view
    }()
    
    var alarmOnOffBtn: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.onTintColor = .systemOrange
        view.addTarget(self, action: #selector(switchOnOff), for: .allTouchEvents)
        return view
    }()
    
    var sleepTimeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "알람 없음"
        view.textColor = .white
        view.font = .systemFont(ofSize: 45)
        return view
    }()
    
    var editBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("변경", for: .normal)
        view.setTitleColor(.systemOrange, for: .normal)
        view.backgroundColor = .darkGray.withAlphaComponent(0.5)
        view.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        return view
    }()
    
    

}

extension AlarmCell{
    private func setUp() {
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(intervalLabel)
        contentView.addSubview(alarmOnOffBtn)
        self.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            timeLabel.heightAnchor.constraint(equalToConstant: 40),
            
            intervalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            intervalLabel.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            intervalLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
//            intervalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            alarmOnOffBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            alarmOnOffBtn.widthAnchor.constraint(equalToConstant: 20),
            alarmOnOffBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            alarmOnOffBtn.leadingAnchor.constraint(equalTo: alarmOnOffBtn.trailingAnchor, constant: 30)
            
        ])
        
        contentView.addSubview(sleepTimeLabel)
        contentView.addSubview(editBtn)
        
        NSLayoutConstraint.activate([
            sleepTimeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            sleepTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sleepTimeLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            editBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            editBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            editBtn.leadingAnchor.constraint(equalTo: editBtn.trailingAnchor, constant: -50),
            editBtn.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        editBtn.layer.cornerRadius = 15
        editBtn.clipsToBounds = true
    }
    
    @objc
    private func switchOnOff(_ sender: Any) {
        self.delegate?.switchOnOff(indexPath: self.indexPath!)
    }

    func firstVisible(isFirst: Bool) {
        self.timeLabel.isHidden = isFirst
        self.intervalLabel.isHidden = isFirst
        self.alarmOnOffBtn.isHidden = isFirst
        
        self.sleepTimeLabel.isHidden = !isFirst
        self.editBtn.isHidden = !isFirst
    }
}

protocol AlarmCellDelegate {
    func switchOnOff(indexPath: IndexPath)
    func beginEditingMode(indexPath: IndexPath)
}
