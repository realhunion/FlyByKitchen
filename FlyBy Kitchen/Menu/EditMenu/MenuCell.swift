//
//  MenuCell.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/11/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit
import QuickLayout


class MenuCell: UITableViewCell {
    
    let priceLabel : UILabel = {
        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.font = UIFont(name: "Avenir-Heavy", size: 18.0)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
//        label.font  = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.font = UIFont(name: "Avenir-Heavy", size: 18.0)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
//        label.font  = UIFont.systemFont(ofSize: 13.0, weight: .regular)
        label.font = UIFont(name: "Avenir-Light", size: 16.0)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 99
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(titleLabel)
        titleLabel.layoutToSuperview(.top, offset: 16.0)
        titleLabel.layoutToSuperview(.left, offset: 16.0)
        
        self.contentView.addSubview(priceLabel)
        priceLabel.layout(.left, to: .right, of: titleLabel, offset: 10.0)
        priceLabel.layoutToSuperview(.top, offset: 16.0)
        priceLabel.layoutToSuperview(.right, offset: -16.0)
        
        self.contentView.addSubview(descriptionLabel)
        descriptionLabel.layout(.top, to: .bottom, of: titleLabel, offset: 4.0)
        descriptionLabel.layoutToSuperview(.left, offset: 16.0)
        descriptionLabel.layoutToSuperview(.right, offset: -64.0)
        descriptionLabel.layoutToSuperview(.bottom, offset: -16.0)
    }
    
}
