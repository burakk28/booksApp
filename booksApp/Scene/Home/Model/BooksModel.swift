//
//  Books.swift
//  booksApp
//
//  Created by Burak Kara on 15.07.2023.
//

import Foundation

// MARK: - BooksModel
struct BooksModel: Codable {
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let kind, id:  String?
    let selfLink: String?
    let volumeInfo: VolumeInfo?
}
// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let publisher, publishedDate, description: String?
    let pageCount: Int?
    let printType: String?
    let categories: [String]?
    let maturityRating: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let comicsContent: Bool?
    let imageLinks: ImageLinks?
    let language: String?
    let previewLink: String?
    let infoLink, canonicalVolumeLink: String?
}

// MARK: - ImageLinks
struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String?
}
