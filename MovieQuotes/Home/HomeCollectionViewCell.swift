//
//  MyCollectionView.swift
//  DemoV11
//
//  Created by Yotaro Ito on 2021/03/10.
//
import UIKit
import Foundation

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCell"
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10.0
        
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.clipsToBounds = true
        label.layer.cornerRadius = 10.0
        label.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return label
    }()
    
    public func configure(with model: Quotes){
        characterNameLabel.text = model.character
        characterImageView.image = UIImage(named: model.imageName)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 20.0
        
        contentView.addSubview(characterImageView)
        characterImageView.addSubview(characterNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
    
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
    
    func configureLayout(){
        
        characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        characterImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        characterImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true

        characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor, constant: 5).isActive = true
        characterNameLabel.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: -10).isActive = true
        characterNameLabel.heightAnchor.constraint(equalTo: characterImageView.heightAnchor, multiplier: 0.2).isActive = true
        characterNameLabel.widthAnchor.constraint(equalTo: characterImageView.widthAnchor, multiplier: 0.65).isActive = true

    }
}
