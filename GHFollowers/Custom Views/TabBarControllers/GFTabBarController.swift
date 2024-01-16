//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 16/01/24.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      UITabBar.appearance().tintColor = UIColor.systemGreen
      viewControllers = [createSearchNC(), createFavoritesNC()]

      
    }
  
  func createSearchNC() -> UINavigationController {
    let searchVC = SearchVC()
    searchVC.title = "Search"
    searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.search,
                                       tag: 0)
    return UINavigationController(rootViewController: searchVC)
  }
  
  func createFavoritesNC() -> UINavigationController {
    let favoritesVC = FavoriteListVC()
    favoritesVC.title = "Favorites"
    favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.favorites,
                                          tag: 1)
    return UINavigationController(rootViewController: favoritesVC)
  }
}
