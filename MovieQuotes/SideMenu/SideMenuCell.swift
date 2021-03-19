//
//  MenuTableViewCell.swift
//  DemoV13
//
//  Created by Yotaro Ito on 2021/03/11.
//

import UIKit

class SideMenuCell: UITableViewCell {

    static let identifier = "SideMenuCell"
    
    let menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor.yellow
        return imageView
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.yellow
        label.numberOfLines = 1
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
  
    private let separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.yellow
        return separator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.black
        contentView.addSubview(separator)
        contentView.addSubview(menuImageView)
        contentView.addSubview(menuLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        menuLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        menuLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        menuLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        menuLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        menuImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        menuImageView.trailingAnchor.constraint(equalTo: menuLabel.safeAreaLayoutGuide.leadingAnchor).isActive = true
        menuImageView.heightAnchor.constraint(equalTo: menuLabel.heightAnchor).isActive = true
        
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        separator.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    
}


