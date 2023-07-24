//
//  HomeController.swift
//  booksApp
//
//  Created by Burak Kara on 3.07.2023.
//

import UIKit
import SDWebImage
import CoreData

class HomeController: UIViewController {
  
  private let bookViewModel = BookViewModel()
  private var newestItems: [Item] = []
  private var popularItems: [Item] = []
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let customLabel = UILabel()
    customLabel.text = "BookShelf"
    customLabel.textColor = UIColor(named: "customMerriBlue")
    if let customFont = UIFont(name: "Merriweather-Black", size: 20) { customLabel.font = customFont }
    let stackView = UIStackView()
    stackView.addArrangedSubview(customLabel)
    self.navigationItem.titleView = stackView
    
    collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
    tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
    fetchBooksData()
    
    func fetchBooksData() {
      bookViewModel.fetchNewestBooks { [weak self] result in
        switch result {
        case .success(let items):
          self?.newestItems = items
          self?.tableView.reloadData()
          self?.collectionView.reloadData()
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
      bookViewModel.fetchPopularBooks { [weak self] result in
        switch result {
        case .success(let items):
          self?.popularItems = items
          self?.collectionView.reloadData()
          self?.tableView.reloadData()
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
}
 // MARK: -CollectionView

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
      let newesItem = newestItems[indexPath.row]
      let bookImgId = newesItem.id!, width = 600, height = 800 ,resolutionURL = "https://books.google.com/books/publisher/content/images/frontcover/\(bookImgId)?fife=w\(width)-h\(height)&source=gbs_api"
      if let thumbnailURL = URL(string: resolutionURL) {
      cell.collectionImageView.sd_setImage(with: thumbnailURL, completed: nil) }
      cell.collectionTitleLabel.text = newesItem.volumeInfo?.title ?? "Unknown Title"
      cell.collectionAuthorsLabel.text = newesItem.volumeInfo?.authors?.first ?? "Unknown Authors"
      return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return newestItems.count
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let selectedBook = newestItems[indexPath.item]
      navigateToDetailPage(with: selectedBook)
  }
}

// MARK: -TableView

extension HomeController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
      let popularItem = popularItems[indexPath.row]
    
      cell.tableImageView.image = nil
    
      let bookImgId = popularItem.id!, width = 600, height = 800 ,resolutionURL = "https://books.google.com/books/publisher/content/images/frontcover/\(bookImgId)?fife=w\(width)-h\(height)&source=gbs_api"
      if let thumbnailURL = URL(string: resolutionURL) {
      cell.tableImageView.sd_setImage(with: thumbnailURL, completed: nil) }
      cell.tableTitleLabel.text = popularItem.volumeInfo?.title ?? "Unknown Title"
      cell.tableAuthorsLabel.text = popularItem.volumeInfo?.authors?.first ?? "Unknown Authors"
      cell.tableDateLabel?.text = popularItem.volumeInfo?.publishedDate ?? "Unknown Date"
      return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return popularItems.count
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let selectedBook = popularItems[indexPath.row]
      navigateToDetailPage(with: selectedBook)
  }
}
