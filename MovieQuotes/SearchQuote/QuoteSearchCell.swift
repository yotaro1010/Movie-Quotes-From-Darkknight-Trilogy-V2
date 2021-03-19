//
//  SampleTableViewCell.swift
//  DemoV13
//
//  Created by Yotaro Ito on 2021/03/14.
//

import UIKit

class QuoteSearchCell: UITableViewCell {
static let identifier = "QuoteSearchCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
    }
    
    func configure(with model: Quotes){
        label.text = model.quote
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
}
