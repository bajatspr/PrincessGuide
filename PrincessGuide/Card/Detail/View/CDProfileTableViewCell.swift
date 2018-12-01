//
//  CDProfileTableViewCell.swift
//  PrincessGuide
//
//  Created by zzk on 2018/5/7.
//  Copyright © 2018 zzk. All rights reserved.
//

import UIKit
import Gestalt

class CDProfileTableViewCell: UITableViewCell, CardDetailConfigurable {

    let stackView = UIStackView()
    
    var itemViews = [ProfileItemView]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectedBackgroundView = UIView()
        
        ThemeManager.default.apply(theme: Theme.self, to: self) { (themeable, theme) in
            themeable.selectedBackgroundView?.backgroundColor = theme.color.tableViewCell.selectedBackground
            themeable.backgroundColor = theme.color.tableViewCell.background
        }
        
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.left.equalTo(readableContentGuide)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.right.equalTo(readableContentGuide)
        }
        
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for items: [Card.Profile.Item]) {
        itemViews.forEach {
            $0.removeFromSuperview()
        }
        itemViews.removeAll()
        
        for item in items {
            let itemView = ProfileItemView()
            itemView.configure(for: item)
            itemViews.append(itemView)
            stackView.addArrangedSubview(itemView)
        }
    }
    
    func configure(for item: CardDetailItem) {
        if case .profileItems(let items) = item {
            configure(for: items)
        } else if case .propertyItems(let items, let unitLevel, let targetLevel, let comparisonMode) = item {
            configure(for: items, unitLevel: unitLevel, targetLevel: targetLevel, comparisonMode: comparisonMode)
        } else {
            fatalError()
        }
    }
    
}

extension CDProfileTableViewCell: MinionDetailConfigurable {
    func configure(for item: MinionDetailItem) {
        guard case .propertyItems(let items, let unitLevel, let targetLevel) = item else {
            return
        }
        configure(for: items, unitLevel: unitLevel, targetLevel: targetLevel, comparisonMode: false)
    }
}
