//
//  TabBarItemsModel.swift
//

import UIKit

enum TabBarItems: String, CaseIterable {
    case home
    case news
    case search
    case profile
    case more
    
    var icon: UIImage {
        switch self {
        case .home:
            return UIImage(named: "home") ?? UIImage()
        case .news:
            return UIImage(named: "news") ?? UIImage()
        case .search:
            return UIImage(named: "search") ?? UIImage()
        case .profile:
            return UIImage(named: "profile") ?? UIImage()
        case .more:
            return UIImage(named: "more") ?? UIImage()
        }
    }
    
    var name: String {
        switch self {
        case .home:
            return "Home"
        case .news:
            return "News"
        case .search:
            return "Search"
        case .profile:
            return "Profile"
        case .more:
            return "More"
        }
    }
    
    var controller: UIViewController {
        switch self {
        case .home:
            return ArticlesViewController()
        case .news:
            return ArticlesViewController()
        case .search:
            return SearchViewController()
        case .profile:
            return ArticlesViewController()
        case .more:
            return ArticlesViewController()
        }
    }
}


