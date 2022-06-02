//
//  Color.swift
//

import UIKit

@objc extension UIColor {
    enum Main {
        static let orange = UIColor(named: "orange")
        static let almostBlack = UIColor(named: "mainAlmostBlack")
        static let background = UIColor(named: "mainBackground")
        static let backgroundGrey = UIColor(named: "lightGrey0")

    }
    
    enum Text {
        static let almostBlack = UIColor(named: "mainAlmostBlack")
        static let lightGrey = UIColor(named: "lightGrey1")
        static let errorColor = UIColor.red
    }
}
