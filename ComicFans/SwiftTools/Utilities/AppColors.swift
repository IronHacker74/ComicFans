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
    
    static func darkBlue() -> UIColor {
        let red: CGFloat = 15/255
        let green: CGFloat = 27/255
        let blue: CGFloat = 33/255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func offWhite() -> UIColor {
        let red: CGFloat = 242/255
        let green: CGFloat = 245/255
        let blue: CGFloat = 236/255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
