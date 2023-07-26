//
//  AddAlarmCell.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/25.
//

import UIKit

class AddAlarmCell: UITableViewCell {

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
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var firstLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    var repeatIsOnSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .systemOrange
        return view
    }()
    
    var accessoryLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemGray
        view.textAlignment = .right
        view.text = "test"
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    var textField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "알람"
//        view.contentHorizontalAlignment = .right
        view.textAlignment = .right
        view.font = .systemFont(ofSize: 16)
        return view
    }()

}

extension AddAlarmCell{
    private func setUp() {
        contentView.addSubview(firstLabel)
        
        NSLayoutConstraint.activate([
            firstLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            firstLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
        ])
        firstLabel.sizeToFit()
        
        contentView.addSubview(repeatIsOnSwitch)
        NSLayoutConstraint.activate([
            repeatIsOnSwitch.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            repeatIsOnSwitch.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
        contentView.addSubview(accessoryLabel)
        NSLayoutConstraint.activate([
            accessoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        accessoryLabel.sizeToFit()
        
        contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            textField.leadingAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    public func labelVisible(row: Int) {
        switch row {
        case 0:
            self.repeatIsOnSwitch.isHidden = true
            self.accessoryLabel.isHidden = false
            self.textField.isHidden = true
            
        case 1:
            self.repeatIsOnSwitch.isHidden = true
            self.accessoryLabel.isHidden = true
            self.textField.isHidden = false
            
        case 2:
            self.repeatIsOnSwitch.isHidden = true
            self.accessoryLabel.isHidden = false
            self.textField.isHidden = true
            
        case 3:
            self.repeatIsOnSwitch.isHidden = false
            self.accessoryLabel.isHidden = true
            self.textField.isHidden = true

        default:
            return
        }
    }
}
