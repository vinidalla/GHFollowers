//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 10/01/24.
//

import UIKit

class FollowerListVC: UIViewController {
  
  var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.systemBackground
      navigationController?.isNavigationBarHidden = false
      navigationController?.navigationBar.prefersLargeTitles = true
    }
}
