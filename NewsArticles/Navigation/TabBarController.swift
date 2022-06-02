    //
    //  TabBarController.swift
    //

import UIKit

final class TabBarController: UITabBarController {
    let items = TabBarItems.allCases
    var previousSelectedIndex: Int = 0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            let tabBarItemAppearance = UITabBarItemAppearance()
            
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = UIColor.Main.background
            tabBar.tintColor = UIColor.Main.orange
            tabBar.standardAppearance = appearance
            
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        
        var controllers: [UINavigationController] = []
        
        for item in items {
            let controller = item.controller
            let navigationController = UINavigationController(rootViewController: controller)
            navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
            
            //Navigation bar color
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.Main.background
            navigationController.navigationBar.tintColor = .Main.orange
            appearance.shadowColor = .clear

            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
            
            
            
            let icon = UITabBarItem(title: item.name, image: item.icon.withRenderingMode(.alwaysTemplate), selectedImage: item.icon.withRenderingMode(.alwaysTemplate))
            controller.tabBarItem = icon
            controllers.append(navigationController)
        }
        viewControllers = controllers
        
        selectedIndex = 0
        delegate = self
    }
}

    // MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        previousSelectedIndex = tabBarController.selectedIndex
    }
}

