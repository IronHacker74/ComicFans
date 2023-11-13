//
//  AppColors.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/11/23.
//

import UIKit

extension UIColor {
    static func cream() -> UIColor {
        let red: CGFloat = 247/255
        let green: CGFloat = 210/255
        let blue: CGFloat = 129/255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func darkBlue() -> UIColor {
        let red: CGFloat = 0
        let green: CGFloat = 50/255
        let blue: CGFloat = 62/255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func darkRed() -> UIColor {
        let red: CGFloat = 144/255
        let green: CGFloat = 39/255
        let blue: CGFloat = 36/255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
