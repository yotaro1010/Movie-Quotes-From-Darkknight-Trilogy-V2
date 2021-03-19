//
//  HomeHeaderCollectionReusableView.swift
//  DemoV13
//
//  Created by Yotaro Ito on 2021/03/13.
//

import UIKit

class HomeHeader: UICollectionReusableView {
  
    let headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .red
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerLabel)
//        headerImageView.addSubview(headerLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame = self.bounds
        headerLabel.frame = self.bounds

    }
    
}



