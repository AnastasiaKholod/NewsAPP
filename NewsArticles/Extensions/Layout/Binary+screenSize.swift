//
//  Binary+screenSize.swift
//
//

import UIKit

extension BinaryFloatingPoint {
    
    /// iPhone X Template: 375 x 812
    var sizeW: CGFloat {
        CGFloat(self) * UIScreen.main.bounds.width / 375
    }
    
    /// iPhone X Template: 375 x 812
    var sizeH: CGFloat {
        CGFloat(self) * UIScreen.main.bounds.height / 812
    }
    
    /// iPhone X Template: 375 x 812
    var lessThanOrEqualToSizeW: CGFloat {
        UIScreen.main.bounds.width < 375 ? self.sizeW : CGFloat(self)
    }
    
    /// iPhone X Template: 375 x 812
    var lessThanOrEqualToSizeH: CGFloat {
        UIScreen.main.bounds.height < 812 ? self.sizeH : CGFloat(self)
    }
    
}

extension BinaryInteger {
    
    /// iPhone X Template: 375 x 812
    var sizeW: CGFloat {
        CGFloat(self).sizeW
    }
    
    /// iPhone X Template: 375 x 812
    var sizeH: CGFloat {
        CGFloat(self).sizeH
    }
    
    /// iPhone X Template: 375 x 812
    var lessThanOrEqualToSizeW: CGFloat {
        CGFloat(self).lessThanOrEqualToSizeW
    }
    
    /// iPhone X Template: 375 x 812
    var lessThanOrEqualToSizeH: CGFloat {
        CGFloat(self).lessThanOrEqualToSizeH
    }
    
}

