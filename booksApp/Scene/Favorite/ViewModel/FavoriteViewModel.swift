//
//  FavoriteViewModel.swift
//  booksApp
//
//  Created by Burak Kara on 18.07.2023.
//

import Foundation
import UIKit
import CoreData
import Firebase

class FavoriteViewModel {
    
    var favorites: [FavoriteItem] = []
    var numberOfFavorites: Int {
        return favorites.count
    }
    func favorite(at index: Int) -> FavoriteItem {
        return favorites[index]
    }

  func getCoreData(forUserID userID: String) {
      self.favorites.removeAll(keepingCapacity: true)

      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
      let context = appDelegate.persistentContainer.viewContext

      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
      fetchRequest.returnsObjectsAsFaults = false
    
      let predicate = NSPredicate(format: "id == %@", userID)
      fetchRequest.predicate = predicate

      do {
          let results = try context.fetch(fetchRequest) as! [NSManagedObject]
          for result in results {
              guard let id = result.value(forKey: "id") as? String,
                    let title = result.value(forKey: "title") as? String,
                    let author = result.value(forKey: "author") as? String,
                    let imageName = result.value(forKey: "imageName") as? String else {
                  continue
              }
              let favorite = FavoriteItem(id: id, title: title, author: author, imageName: imageName)
              self.favorites.append(favorite)
          }
      } catch {
          print(error.localizedDescription)
      }
  }
}
