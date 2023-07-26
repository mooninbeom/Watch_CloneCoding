//
//  SoundSelectionCell.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/21.
//

import UIKit

class SoundSelectionCell: UITableViewCell {

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
    
    var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "test"
        view.textColor = .white
        view.font = .systemFont(ofSize: 20)
        return view
    }()

}

extension SoundSelectionCell {
    private func setUp() {
        self.contentView.backgroundColor = .darkGray
        
        self.contentView.addSubview(self.nameLabel)
        NSLayoutConstraint.activate([
            self.nameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
}
