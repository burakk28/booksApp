//
//  BooksViewModel.swift
//  booksApp
//
//  Created by Burak Kara on 17.07.2023.
//

import Foundation

class BookViewModel {
    private let bookService = BookService()

  func fetchPopularBooks(completion: @escaping (Result<[Item], Error>) -> Void) {
      let popularApi = BookAPI.popular
      bookService.fetchBooks(api: popularApi) { [weak self] result in
          switch result {
          case .success(let items):
              let uniqueItems = self?.filterUniqueItems(items) ?? []
              completion(.success(uniqueItems))
          case .failure(let error):
              completion(.failure(error))
          }
      }
  }

  private func filterUniqueItems(_ items: [Item]) -> [Item] {
      var uniqueItems: [Item] = []
      var seenTitles: Set<String> = []

      uniqueItems = items.filter { item in
        let isUnique = !seenTitles.contains((item.volumeInfo?.title)!)
        seenTitles.insert((item.volumeInfo?.title)!)
          return isUnique
      }
      
      return uniqueItems
  }
    func fetchNewestBooks(completion: @escaping (Result<[Item], Error>) -> Void) {
        let newestApi = BookAPI.newest
        bookService.fetchBooks(api: newestApi) { [weak self] result in
            switch result {
            case .success(let items):
              let uniqueItems = self?.filterUniqueItems(items) ?? []
              completion(.success(uniqueItems))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchBooks(query: String, completion: @escaping (Result<[Item], Error>) -> Void) {
        let searchApi = BookAPI.search(query: query)
        bookService.fetchBooks(api: searchApi) { [weak self] result in
            switch result {
            case .success(let items):
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
