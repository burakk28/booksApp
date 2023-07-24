//
//  CoreDataHelper.swift
//  booksApp
//
//  Created by Burak Kara on 20.07.2023.
//

import UIKit
import CoreData

class CoreDataHelpers {
    
    static let shared = CoreDataHelpers()
    
    private init() {}
    
    func addFavorite(id:String,title: String, author: String?, imageName: String?) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let saveData = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context)
        saveData.setValue(id, forKey: "id")
        saveData.setValue(title, forKey: "title")
        saveData.setValue(author, forKey: "author")
        saveData.setValue(imageName, forKey: "imageName")
        do {
            try context.save()
        } catch {
          print("\(error.localizedDescription)")
        }
    }
  
    func removeFavorite(id:String,title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            if let objectToDelete = fetchedResults.first as? NSManagedObject {
                context.delete(objectToDelete)
                try context.save()
            }
        } catch {
          print("\(error.localizedDescription)")
        }
    }
  
  func isFavorite(id: String, title: String) -> Bool {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return false
      }
      let context = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
      fetchRequest.predicate = NSPredicate(format: "id == %@ AND title == %@", id, title)

      do {
          let fetchedResults = try context.fetch(fetchRequest)
          return !fetchedResults.isEmpty
      } catch {
        print("Error fetching data: \(error.localizedDescription)")
          return false
      }
  }

    func deleteCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
        } catch {
            print("Core Data Delete Error")
        }
    }
}
