    //
    //  UIView.swift
    //

import UIKit

extension UIView {
    @discardableResult
    open func roundWidth() -> Self {
        clipsToBounds = true
        layer.cornerRadius = frame.width / 2
        return self
    }
    
    @discardableResult
    open func roundHeight() -> Self {
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2
        return self
    }
    
    @discardableResult
    open func roundShape() -> Self {
        clipsToBounds = true
        layer.cornerRadius = frame.height > frame.width ? frame.height / 2 : frame.width / 2
        return self
    }
    
    var cornerRadius: CGFloat {
        set {layer.cornerRadius = newValue}
        get {return layer.cornerRadius}
    }
    
    open func setupShadow(opacity: Float = 0, radius: CGFloat = 0, offset: CGSize = .zero, color: UIColor = .black) {
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
    
    open func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.08
        self.layer.shadowRadius = 7
        self.layer.shadowOffset.height = 7
        self.layer.shadowColor = UIColor.black.cgColor
    }
}

