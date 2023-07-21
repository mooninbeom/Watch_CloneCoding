//
//  WorldWideClockHeaderView.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/13.
//

import UIKit

class WorldWideClockHeaderView: UITableViewHeaderFooterView {
    
    var worldLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "세계 시계"
        view.font = .systemFont(ofSize: 35, weight: .bold)
        view.textAlignment = .left
        view.textColor = .white
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.contentView.addSubview(worldLabel)
        self.worldLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.worldLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
    }

}
