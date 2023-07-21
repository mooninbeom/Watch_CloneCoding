//
//  CityListCell.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/15.
//

import UIKit

class CityListCell: UITableViewCell {
    
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
    
    var cityLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.textAlignment = .left
        return view
    }()
    
    private func setUp() {
        self.contentView.addSubview(cityLabel)
        self.cityLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.cityLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
}
