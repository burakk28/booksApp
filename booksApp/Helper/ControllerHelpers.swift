//
//  ControllerHelpers.swift
//  booksApp
//
//  Created by Burak Kara on 10.07.2023.
//

import UIKit

extension HomeController{
  
  func navigateToDetailPage(with book: Item) {
       performSegue(withIdentifier: "toDetail", sender: book)
   }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "toDetail" {
          if let detailViewController = segue.destination as? DetailViewController,
             let book = sender as? Item {
              let viewModel = DetailViewModel(book: book)
              detailViewController.viewModel = viewModel
          }
      }
  }
}
extension SearchViewController {
  
  func navigateToDetailPage(with book: Item) {
         performSegue(withIdentifier: "toDetail2", sender: book)
     }
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "toDetail2" {
              if let detailViewController = segue.destination as? DetailViewController,
                 let book = sender as? Item {
                  let viewModel = DetailViewModel(book: book)
                  detailViewController.viewModel = viewModel
              }
          }
      }
  }


