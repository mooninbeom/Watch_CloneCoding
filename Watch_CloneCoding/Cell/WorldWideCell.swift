//
//  WorldWideCell.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/13.
//

import UIKit

class WorldWideCell: UITableViewCell {
    
    
    var regionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .systemFont(ofSize: 25, weight: .semibold)
        return view
    }()
    
    var timeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        view.font = .systemFont(ofSize: 60, weight: .light)
        view.textColor = .white
        return view
    }()
    
    var dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    
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
    
    
    private func setUp() {
        self.backgroundColor = .clear
        
        self.contentView.addSubview(regionLabel)
        self.regionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.regionLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 5).isActive = true
        self.regionLabel.trailingAnchor.constraint(equalTo: self.regionLabel.leadingAnchor, constant: 170).isActive = true
        self.regionLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.contentView.addSubview(dateLabel)
        self.dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.dateLabel.bottomAnchor.constraint(equalTo: self.regionLabel.topAnchor).isActive = true
        self.dateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.dateLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.contentView.addSubview(timeLabel)
        self.timeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.timeLabel.leadingAnchor.constraint(equalTo: self.timeLabel.trailingAnchor, constant: -160).isActive = true
        self.timeLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }

}
