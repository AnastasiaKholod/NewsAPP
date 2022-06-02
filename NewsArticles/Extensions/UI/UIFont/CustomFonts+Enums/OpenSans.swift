//
//  OpenSans.swift
//
//  Created by Anastasia Kholod on 19.01.2022.
//

import UIKit

extension UIFont {
    enum OpenSans {
        static func regular(size: CGFloat) -> UIFont? {
            return UIFont(name: "OpenSans-Regular", size: size.sizeW)
        }
        
        static func lightItalic(size: CGFloat) -> UIFont? {
            return UIFont(name: "OpenSans-LightItalic", size: size.sizeW)
        }
    }
}

enum OpenSans: String, CustomFont {
    case regular = "OpenSans-Regular"
    case lightItalic = "OpenSans-LightItalic"

    func fontName() -> String {
        return self.rawValue
    }
}
