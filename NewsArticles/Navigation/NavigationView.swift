    //
    //  NavigationView.swift
    //  NewsArticles
    //
    //  Created by Anastasia Kholod on 30.05.2022.
    //

import UIKit

class NavigationView: UIView  {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .Main.background
        clipsToBounds = true
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.addShadow()
    }
}
