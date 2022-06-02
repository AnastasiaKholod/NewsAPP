//
//  CGSize.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/25/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

extension CGSize {
    static func <=(left: CGSize, right: CGSize) -> Bool {
        return (left.width * left.height) <= (right.width * right.height)
    }
    
    static func >=(left: CGSize, right: CGSize) -> Bool {
        return (left.width * left.height) >= (right.width * right.height)
    }
}
