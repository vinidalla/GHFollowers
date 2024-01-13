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
  var page: Int = 1
  var hasMoreFollowers: Bool = true
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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
    navigationController?.navigationBar.tintColor = UIColor.systemGreen
  }
  
  func configureViewController() {
    view.backgroundColor = UIColor.systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds,
                                      collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.backgroundColor = UIColor.systemBackground
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
  }
  
  func getFollowers(username: String?, page: Int) {
    guard let username = username else { return }
    NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case Result.success(let followers):
        if followers.count < 100 {
          self.hasMoreFollowers = false
        }
        self.followers.append(contentsOf: followers)
        self.updateData()
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
  
  func updateData() { //snapshot sets up the initial state of the data that a view displays, we use snapshots to reflect changes to the data that the view displays.
    var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapShot.appendSections([Section.main])
    snapShot.appendItems(followers)
    DispatchQueue.main.async {
//      guard let dataSource = self.dataSource else { return }
      self.dataSource?.apply(snapShot, animatingDifferences: true)
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
}
