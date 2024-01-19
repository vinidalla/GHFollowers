//
//  FavoriteListVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 04/01/24.
//

import UIKit

class FavoriteListVC: UIViewController {
  
  let tableView: UITableView = UITableView()
  var favorites: [Follower] = []
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getFavorites()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureTableView()
    tableView.reloadData()
  }
  
  func configureViewController() {
    view.backgroundColor = UIColor.systemBackground
    title = GeneralStrings.favorites
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func configureTableView() {
    view.addSubview(tableView)
    tableView.frame = view.bounds
    tableView.rowHeight = 80
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    tableView.layoutMargins = UIEdgeInsets.zero
    tableView.separatorInset = UIEdgeInsets.zero
  }
  
  func getFavorites() {
    PersistenceManager.retrieveFavorites { [weak self] result in
      guard let self = self else { return }
      switch result {
      case Result.success(let favorites):
        self.updateUI(with: favorites)
      case Result.failure(let error):
        self.presentGFAlertOnMainThread(title: GeneralStrings.somethingWentWrong,
                                        message: error.rawValue,
                                        buttonTitle: GeneralStrings.ok)
      }
    }
  }
  
  func updateUI(with favorites: [Follower]) {
    if favorites.isEmpty {
      self.showEmptyStateView(with: GeneralStrings.noFavoritesAddOne, in: self.view)
    } else {
      self.favorites = favorites
      DispatchQueue.main.async {
        self.tableView.reloadData()
        self.view.bringSubviewToFront(self.tableView)
      }
    }
  }
}

extension FavoriteListVC: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
    let favorite = favorites[indexPath.row]
    cell.set(favorite: favorite)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let favorite = favorites[indexPath.row]
    let destinationVC = FollowerListVC(username: favorite.login)
    navigationController?.pushViewController(destinationVC, animated: true)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == UITableViewCell.EditingStyle.delete else { return }
    
    PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: PersistenceActionType.remove) { [weak self] error in
      guard let self = self else { return }
      guard let error = error else {
        self.favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
        return
      }
      self.presentGFAlertOnMainThread(title: GeneralStrings.unableToRemove,
                                      message: error.rawValue,
                                      buttonTitle: GeneralStrings.ok)
    }
  }
}
