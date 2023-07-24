//
//  BookService.swift
//  booksApp
//
//  Created by Burak Kara on 15.07.2023.
//

import Foundation
import Alamofire

enum BookAPI {
  
    case popular
    case newest
    case search(query: String)
    
    var baseUrl: String {
        let baseUrl = "https://www.googleapis.com/books/v1/volumes?"
        
        switch self {
        case .popular:
            return baseUrl + "q=popular&orderBy=newest&maxResults=40"
        case .newest:
            return baseUrl + "q=newest&orderBy=newest&maxResults=40"
        case .search(let query):
            let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return baseUrl + "q=\(encodedQuery)&orderBy=relevance&maxResults=40"
        }
    }
}
class BookService {
  
  func fetchBooks(api: BookAPI, completion: @escaping (Result<[Item], Error>) -> Void) {
      let baseUrl = api.baseUrl
      
      AF.request(baseUrl).responseDecodable(of: BooksModel.self) { response in
          switch response.result {
          case .success(let booksModel):
              if let items = booksModel.items {
                  completion(.success(items))
              } else {
                  completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey:
                                                                                "No books found"])))
              }
          case .failure(let error):
              completion(.failure(error))
          }
      }
   }
}
