//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 10/01/24.
//

import UIKit

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
  var isLoadingMoreFollowers: Bool = false
  var collectionView = UICollectionView(frame: CGRect.zero,
                                        collectionViewLayout: UICollectionViewFlowLayout())
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>?
  
  init(username: String) {
    super.init(nibName: nil, bundle: nil)
    self.username = username
    title = username
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureSearchController()
    configureCollectionView()
    getFollowers(username: username, page: page)
    configureDataSource()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    collectionView.reloadData()
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
    searchController.searchBar.placeholder = GeneralStrings.searchForUsername
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
  }
  
  func getFollowers(username: String?, page: Int) {
    showLoadingView()
    isLoadingMoreFollowers = true
    guard let username = username else { return }
    NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in

      guard let self = self else { return }
      self.dismissLoadingView()
      switch result {
      case Result.success(let followers):
        if followers.count < 100 {
          self.hasMoreFollowers = false
        }
        self.followers.append(contentsOf: followers)
        if self.followers.isEmpty {
          let message = GeneralStrings.userHasNoFollowers
          DispatchQueue.main.async {
            self.showEmptyStateView(with: message, in: self.view)
            self.navigationItem.searchController?.isActive = false
          }
        }
        self.updateData(on: self.followers)
      case Result.failure(let error):
        self.presentGFAlertOnMainThread(title: GeneralStrings.somethingWentWrong,
                                        message: error.rawValue,
                                        buttonTitle: GeneralStrings.ok)
      }
      self.isLoadingMoreFollowers = false
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
  
  func updateData(on followers: [Follower]) {
    var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapShot.appendSections([Section.main])
    snapShot.appendItems(followers)
    DispatchQueue.main.async {
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
            self.presentGFAlertOnMainThread(title: GeneralStrings.success,
                                            message: GeneralStrings.successfullyFavoriteUser,
                                            buttonTitle: GeneralStrings.nice)
            return
          }
          
          self.presentGFAlertOnMainThread(title: GeneralStrings.somethingWentWrong,
                                          message: error.rawValue,
                                          buttonTitle: GeneralStrings.ok)
        }
        
      case Result.failure(let error):
        self.presentGFAlertOnMainThread(title: GeneralStrings.somethingWentWrong,
                                        message: error.rawValue,
                                        buttonTitle: GeneralStrings.ok)
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
      guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
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

extension FollowerListVC: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text, !filter.isEmpty else {
      filteredFollowers.removeAll()
      updateData(on: followers)
      isSearching = false
      return
    }
    
    isSearching = true
    filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
    updateData(on: filteredFollowers)
  }
}

extension FollowerListVC: UserInfoVCDelegate {
  func didRequestFollowers(username: String) {
    self.username = username
    title = username
    page = 1
    followers.removeAll()
    filteredFollowers.removeAll()
    collectionView.setContentOffset(CGPoint.zero, animated: true)
    collectionView.scrollsToTop = true
    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                at: UICollectionView.ScrollPosition.top,
                                animated: true)
    getFollowers(username: username, page: page)
  }
}
