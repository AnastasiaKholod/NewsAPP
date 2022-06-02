    //
    //  UIButton+Style.swift
    //
    //  Created by Anastasia Kholod on 30.12.2021.
    //  Copyright © 2022 Anastasia Kholod. All rights reserved.
    //

import Foundation
import UIKit

extension UIButton {
    func orangeButton(title: String) -> UIButton {
        let obj = UIButton(type: .system)
                
        obj.snp.makeConstraints { make in
            make.height.equalTo(50.sizeH)
            make.width.equalTo(343.sizeW)
        }
        
        let titleColor = UIColor.white
        let backgroundColor = UIColor.Main.orange
        
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.foregroundColor] = titleColor
        attributes[.font] = UIFont.OpenSans.regular(size:15)
        attributes[.kern] = 0.72
        
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        obj.setAttributedTitle(attributedString, for: .normal)
        
        obj.backgroundColor = backgroundColor
        obj.cornerRadius = 25
        obj.clipsToBounds = true
        
        return obj
    }

}
