//
//  UIView+shadow.swift
//

import Foundation
import UIKit

extension UIView {
    func addShadowAndRoundCorners(){
        self.backgroundColor = .white
        self.cornerRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 5
        self.layer.shadowOffset.height = 5
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
