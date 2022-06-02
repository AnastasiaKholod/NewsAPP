//
//  UIFont.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/26/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

protocol CustomFont {
    func fontName() -> String
}

extension UIFont {
    convenience init?(font: CustomFont, size: CGFloat) {
        self.init(name: font.fontName(), size: size)!
    }
}
