//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 10/01/24.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
  func didRequestFollowers(username: String)
}

class FollowerListVC: UIViewController {
  
  enum Section {
    case main
  }
  
  var username: String?
  var followers: [Follower] = []
  var filteredFollowers: [Follower] = []
  var page: Int = 1
  var hasMoreFollowers: Bool = true
  var isSearching: Bool = false
//  var collectionView: UICollectionView!
  var collectionView = UICollectionView(frame: CGRect.zero,
                                        collectionViewLayout: UICollectionViewFlowLayout())
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureCollectionView()
    getFollowers(username: username ?? "username", page: page)
    configureDataSource()
    configureSearchController()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
    navigationController?.navigationBar.tintColor = UIColor.systemGreen
  }
  
  func configureViewController() {
    view.backgroundColor = UIColor.systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                     target: self,
                                     action: #selector(addButtonTapped))
    navigationItem.rightBarButtonItem = addButton
  }
  
  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds,
                                      collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.backgroundColor = UIColor.systemBackground
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
  }
  
  func configureSearchController() {
    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Search for a username"
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
  }
  
  func getFollowers(username: String?, page: Int) {
    showLoadingView()
    guard let username = username else { return }
    NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in

      guard let self = self else { return }
      dismissLoadingView()
      switch result {
      case Result.success(let followers):
        if followers.count < 100 {
          self.hasMoreFollowers = false
        }
        self.followers.append(contentsOf: followers)
        if self.followers.isEmpty {
          let message = "This user doesn't have any followers yet 😁."
          DispatchQueue.main.async {
            self.showEmptyStateView(with: message, in: self.view)
          }
        }
        self.updateData(on: self.followers)
      case Result.failure(let error):
        self.presentGFAlertOnMainThread(title: "Bad stuff happend",
                                        message: error.rawValue,
                                        buttonTitle: "Ok")
      }
    }
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView,
                                                                       cellProvider: { collectionView, indexPath, follower in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
      cell.set(follower: follower)
      return cell
    })
  }
  
  func updateData(on followers: [Follower]) { //snapshot sets up the initial state of the data that a view displays, we use snapshots to reflect changes to the data that the view displays.
    var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapShot.appendSections([Section.main])
    snapShot.appendItems(followers)
    DispatchQueue.main.async {
//      guard let dataSource = self.dataSource else { return }
      self.dataSource?.apply(snapShot, animatingDifferences: true)
    }
  }
  
  @objc func addButtonTapped() {
    showLoadingView()
    guard let username = username else { return }
    NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
      guard let self = self else { return }
      self.dismissLoadingView()
      
      switch result {
      case Result.success(let user):
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: PersistenceActionType.add) { [weak self] error in
          guard let self = self else { return }
          guard let error = error else {
            self.presentGFAlertOnMainThread(title: "Success!",
                                            message: "You have successfully favorited this user.",
                                            buttonTitle: "Nice!")
            return
          }
          
          self.presentGFAlertOnMainThread(title: "Something went wrong",
                                          message: error.rawValue,
                                          buttonTitle: "Ok")
        }
        
      case Result.failure(let error):
        self.presentGFAlertOnMainThread(title: "Something went wrong",
                                        message: error.rawValue,
                                        buttonTitle: "Ok")
      }
    }
  }
}

extension FollowerListVC: UICollectionViewDelegate {
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.size.height
    
    if offsetY > contentHeight - height {
      guard hasMoreFollowers else { return }
      page += 1
      getFollowers(username: username, page: page)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let activeArray = isSearching ? filteredFollowers : followers
    
    let follower = activeArray[indexPath.item]
    
    let destinationVC = UserInfoVC()
    destinationVC.username = follower.login
    destinationVC.delegate = self
    
    let navController = UINavigationController(rootViewController: destinationVC)
    present(navController, animated: true)
  }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
    isSearching = true
    //checking the login name if it contains what is in your filter throw that into the filtered followers array
    filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
    updateData(on: filteredFollowers)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    isSearching = false
    updateData(on: followers)
  }
}

extension FollowerListVC: FollowerListVCDelegate {
  func didRequestFollowers(username: String) {
    self.username = username
    title = username
    page = 1
    followers.removeAll()
    filteredFollowers.removeAll()
    collectionView.setContentOffset(CGPoint.zero, animated: true)
    getFollowers(username: username, page: page)
  }
}
