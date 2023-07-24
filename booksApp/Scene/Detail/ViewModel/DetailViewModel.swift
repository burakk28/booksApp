//
//  DetailViewModel.swift
//  booksApp
//
//  Created by Burak Kara on 18.07.2023.
//

import Foundation

class DetailViewModel {
  
    var book: Item
    
    init(book: Item) {
        self.book = book
    }
    var imageThumbnailURL: String? {
      if (book.volumeInfo?.imageLinks?.thumbnail) != nil {
        let bookImgId = book.id!, width = 600, height = 800
            let resolutionURL = "https://books.google.com/books/publisher/content/images/frontcover/\(bookImgId)?fife=w\(width)-h\(height)&source=gbs_api"
            return resolutionURL
        } else {
          return nil
      }
    }
    var title: String {
      return book.volumeInfo?.title ?? "Unknown Title"
    }
    var author: String? {
      return book.volumeInfo?.authors?.first ??  "Unknown Author"
    }
    var publishedDate: String? {
      return book.volumeInfo?.publishedDate ?? "Unknown Date"
    }
    var language: String? {
      return book.volumeInfo?.language?.uppercased() ?? "Unknown Language"
    }
    var pageCount: Int {
      return book.volumeInfo?.pageCount ?? 0
    }
    var aboutText: String {
      return book.volumeInfo?.description ?? "Unknown About"
    }
}
