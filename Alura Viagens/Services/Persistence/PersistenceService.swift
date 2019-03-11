//
//  PersistenceService.swift
//  Alura Viagens
//
//  Created by Ivan De Martino on 3/9/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceService {

  private init () {}
  static let shared = PersistenceService()
  // MARK: - Core Data contex

  lazy var context = persistentContainer.viewContext

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Alura_Viagens")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  // MARK: - fetch

  func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T]? {
    let entityName = String(describing: objectType)
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    do {
      let fetchedObject = try context.fetch(fetchRequest) as? [T]
      return fetchedObject
    } catch  {
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
  }

  // MARK: - delete

  func delete<T: NSManagedObject>(_ object: T) {
    context.delete(object)
    saveContext()
  }

  // MARK: - Core Data Saving support

  func saveContext () {
    if context.hasChanges {
      do {
        try context.save()
        print("save")
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
}
