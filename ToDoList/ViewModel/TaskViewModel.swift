//
//  TaskViewModel.swift
//  ToDoList
//
//  Created by Jonathan Valentino on 06/08/23.
//

import CoreData
import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks = [Item]()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            } else {
                print("Successfully loaded Core Data")
            }
        }
        
        getItem()
    }
    
    func getItem() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()

        do {
            tasks = try container.viewContext.fetch(fetchRequest)

        } catch {
            print("Error fetching. \(error)")
        }
    }
    
    func addItem(title: String, description: String, due: Date) {
//        guard !title.isEmpty, !description.isEmpty else { return }
        let newItem = Item(context: container.viewContext)
        newItem.title = title
        newItem.desc = description
        newItem.due = due

        do {
            try container.viewContext.save()
            getItem()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            print("Failed to save context \(error)")
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        offsets.map { tasks[$0] }.forEach(container.viewContext.delete)

        do {
            try container.viewContext.save()
            getItem()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
