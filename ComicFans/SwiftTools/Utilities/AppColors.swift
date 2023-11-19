//
//  AppColors.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/11/23.
//

import UIKit

extension UIColor {
    static func marvelRed() -> UIColor {
        let red: CGFloat = 144/255
        let green: CGFloat = 39/255
        let blue: CGFloat = 35/255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func darkGrey() -> UIColor {
        let red: CGFloat = 80/255
        let green: CGFloat = 74/255
        let blue: CGFloat = 74/255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func orange() -> UIColor {
        let red: CGFloat = 247/255
        let green: CGFloat = 143/255
        let blue: CGFloat = 63/255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
