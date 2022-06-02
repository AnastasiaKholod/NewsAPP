//
//  SizeHelper.swift
//  AppTemplate
//
//  Created by Anastasia Kholod on 11/27/17.
//  Copyright © 2022 Anastasia Kholod. All rights reserved.
//

import Foundation
import UIKit

class SizeHelper {
    static let screen = UIScreen.main.bounds
    
    // MARK: - Size funcs (default - iPhone X screen size, iPad 9.7-inch)
    static func sizeW(_ size: CGFloat, sizeForRotation: CGSize? = nil) -> CGFloat {
        var screenWidth = UIScreen.main.bounds.width
        if let sizeForRotation = sizeForRotation {
            screenWidth = sizeForRotation.width
        }
        
        return (size * screenWidth) / (DeviceHelper.isIPad ? 768 : 375 )
    }
    
    static func sizeH(_ size: CGFloat, sizeForRotation: CGSize? = nil) -> CGFloat {
        var screenHeight = UIScreen.main.bounds.height
        if let sizeForRotation = sizeForRotation {
            screenHeight = sizeForRotation.height
        }
        
        return (size * screenHeight) / (DeviceHelper.isIPad ? 1024 : 812)
    }
}
