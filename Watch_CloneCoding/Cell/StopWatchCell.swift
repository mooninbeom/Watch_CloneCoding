//
//  StopWatchCell.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/11.
//

import UIKit

class StopWatchCell: UITableViewCell {

    var lapCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .monospacedDigitSystemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    func setUp() {
        self.backgroundColor = .black
        self.addSubview(lapCountLabel)
        self.lapCountLabel.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.lapCountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        self.lapCountLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addSubview(timeLabel)
        self.timeLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
