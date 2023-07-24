//
//  SearchViewModel.swift
//  booksApp
//
//  Created by Burak Kara on 20.07.2023.
//

import Foundation

class SearchViewModel {
    private let bookService = BookService()

    var searchResults: [Item] = []
    
    func performSearch(with searchText: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if searchText.isEmpty {
            searchResults = []
            completion(.success(()))
        } else {
            bookService.fetchBooks(api: .search(query: searchText)) { [weak self] result in
                switch result {
                case .success(let items):
                    self?.searchResults = items
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
