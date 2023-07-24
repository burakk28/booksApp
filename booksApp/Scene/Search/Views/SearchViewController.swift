//
//  SearchViewController.swift
//  booksApp
//
//  Created by Burak Kara on 11.07.2023.
//

import UIKit

class SearchViewController: UIViewController {

  @IBOutlet weak var booksSearchBar: UISearchBar!
  @IBOutlet weak var searchTableView: UITableView!
  private let viewModel = SearchViewModel()
  
  override func viewDidLoad() {
        super.viewDidLoad()
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "customMerriBlue")]
    self.navigationController?.navigationBar.backgroundColor = UIColor(named: "backgroundColor")
      searchTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
    }
}
extension SearchViewController:UITableViewDelegate,UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.searchResults.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = searchTableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
    
    let book = viewModel.searchResults[indexPath.row]
    cell.tableTitleLabel.text = book.volumeInfo?.title ?? "Unknown Title"
    cell.tableDateLabel?.text = book.volumeInfo?.publishedDate ?? "Unknown Date"
    cell.tableAuthorsLabel.text = book.volumeInfo?.authors?.first ?? "Unknown Author"
    if let thumbnailURLString = book.volumeInfo?.imageLinks?.thumbnail,
       let thumbnailURL = URL(string: thumbnailURLString) {
       cell.tableImageView.sd_setImage(with: thumbnailURL, completed: nil)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedBook = viewModel.searchResults[indexPath.row]
    navigateToDetailPage(with: selectedBook)
     }
}
// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.performSearch(with: searchText) { [weak self] result in
            switch result {
            case .success:
                self?.searchTableView.reloadData()
            case .failure(let error):
              print("Search Error: \(error.localizedDescription)")
            }
        }
    }
}
