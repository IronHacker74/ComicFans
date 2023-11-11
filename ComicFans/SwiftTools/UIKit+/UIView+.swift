//
//  UIView+.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/5/23.
//

import UIKit

extension UIView {
    class func initFromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

protocol UIViewLoading {}

extension UIViewLoading where Self : UIView {
    
    static func loadFromNib(nibNameOrNil: String? = nil) -> Self {
        let nibName = nibNameOrNil ?? self.className
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
    
    static private var className: String {
        let className = "\(self)"
        let components = className.split{$0 == "."}.map ( String.init )
        return components.last!
    }
}

extension UIViewLoading where Self : UIViewController {
    static func loadFromNibMain(nibNameOrNil: String? = nil) -> Self{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let name = nibNameOrNil ?? vcClassName
        let vc = storyBoard.instantiateViewController(withIdentifier: name)
        return vc as! Self
    }
    
    static private var vcClassName: String {
        let className = "\(self)"
        let components = className.split{$0 == "."}.map ( String.init )
        return components.last!
    }
}

