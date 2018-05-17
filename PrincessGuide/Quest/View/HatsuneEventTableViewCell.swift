//
//  HatsuneEventTableViewCell.swift
//  PrincessGuide
//
//  Created by zzk on 2018/5/17.
//  Copyright © 2018 zzk. All rights reserved.
//

import UIKit
import Gestalt

class HatsuneEventTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    
    let subtitleLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectedBackgroundView = UIView()
        
        ThemeManager.default.apply(theme: Theme.self, to: self) { (themable, theme) in
            themable.titleLabel.textColor = theme.color.title
            themable.subtitleLabel.textColor = theme.color.lightText
            themable.selectedBackgroundView?.backgroundColor = theme.color.tableViewCell.selectedBackground
            themable.backgroundColor = theme.color.tableViewCell.background
        }
        
        titleLabel.font = UIFont.scaledFont(forTextStyle: .title3, ofSize: 16)
        if #available(iOS 11.0, *) {
            titleLabel.adjustsFontForContentSizeCategory = true
            subtitleLabel.adjustsFontForContentSizeCategory = true
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(readableContentGuide)
            make.centerY.equalToSuperview()
        }
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(readableContentGuide)
            make.bottom.equalTo(titleLabel.snp.top)
        }
        subtitleLabel.font = UIFont.scaledFont(forTextStyle: .title3, ofSize: 14)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }

}
