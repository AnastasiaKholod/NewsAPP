//
//  UIView+border.swift

//

import UIKit
import SnapKit

extension UIView{
    func addTopBorder(x: CGFloat, color: UIColor, height: CGFloat, alpha: Float, width: CGFloat = UIScreen.main.bounds.width)
    {
        let topBorder = UIView()
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        topBorder.backgroundColor = color
        topBorder.layer.opacity = alpha
        self.addSubview(topBorder)
        
        topBorder.snp.makeConstraints { (make) in
            make.left.equalTo(x)
            make.top.equalToSuperview()
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
    }
    
    func addBottomBorder(x: CGFloat, color: UIColor, height: CGFloat, alpha: Float, width: CGFloat = UIScreen.main.bounds.width)
    {
        let bottomBorder = UIView()
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = color
        bottomBorder.layer.opacity = alpha
        self.addSubview(bottomBorder)
        
        bottomBorder.snp.makeConstraints { (make) in
            make.left.equalTo(x)
            make.top.equalTo(self.snp.bottom)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
    }
    
    func addFullBottomBorder(color: UIColor, alpha: Float) {
        let bottomBorder = UIView()
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = color
        bottomBorder.layer.opacity = alpha
        self.addSubview(bottomBorder)
        
        bottomBorder.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
