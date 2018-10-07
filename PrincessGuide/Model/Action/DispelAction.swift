//
//  DispelAction.swift
//  PrincessGuide
//
//  Created by zzk on 2018/10/2.
//  Copyright © 2018 zzk. All rights reserved.
//

import Foundation

class DispelAction: ActionParameter {

    enum DispelType: Int, CustomStringConvertible {
        case buff = 1
        case debuff
        
        var description: String {
            switch self {
            case .buff:
                return NSLocalizedString("buffs", comment: "")
            case .debuff:
                return NSLocalizedString("debuffs", comment: "")
            }
        }
    }
    
    var dispelType: DispelType? {
        return DispelType(rawValue: actionDetail1)
    }
    
    var chanceValues: [ActionValue] {
        return [
            ActionValue(initial: String(actionValue1), perLevel: String(actionValue2), key: nil)
        ]
    }
    
    override func localizedDetail(of level: Int, property: Property, style: EDSettingsViewController.Setting.ExpressionStyle) -> String {
        let format = NSLocalizedString("Clear all %@ on %@ with chance [%@]%%.", comment: "")
        if let dispelType = self.dispelType {
            return String(format: format, dispelType.description, targetParameter.buildTargetClause(), buildExpression(of: level, actionValues: chanceValues, roundingRule: nil, style: style, property: property))
        } else {
            return super.localizedDetail(of: level, property: property, style: style)
        }
    }
}
