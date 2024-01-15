//
//  FavoriteListVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 04/01/24.
//

import UIKit

class FavoriteListVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.systemBlue
    
    PersistenceManager.retrieveFavorites { result in
      switch result {
      case Result.success(let favorites):
        print(favorites)
      case Result.failure(let error):
        break
      }
    }

  }
}
