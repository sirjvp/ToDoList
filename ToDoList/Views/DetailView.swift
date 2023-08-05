//
//  DetailView.swift
//  ToDoList
//
//  Created by Jonathan Valentino on 02/08/23.
//

import CoreData
import SwiftUI

struct DetailView: View {
    @ObservedObject var vm: TaskViewModel

    @State private var showModal = false
    @State var type = "Edit Task"
    @State var task: Item

    var body: some View {
        VStack {
            Form {
                // Title
                Text(task.title ?? "")
                    .font(.headline)

                // Description
                Text(task.desc ?? "")
                    .foregroundColor(.gray)

                // Due Date
                HStack {
                    Text("Due Date")
                    Spacer()
                    Text(task.due ?? Date.now, formatter: itemFormatter)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationBarTitle(Text("Detail View"), displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { self.showModal.toggle()
                }) {
                    Text("Edit")
                }
                .sheet(isPresented: $showModal) {
                    SaveView(vm: vm, showModal: $showModal, type: $type, task: task, title: task.title!, description: task.desc!, due: task.due!)
                }
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a preview ManagedObjectContext
        let context = PersistenceController.preview.container.viewContext

        // Create a dummy Item and add it to the context
        let dummyItem = Item(context: context)
        dummyItem.title = "Lorem ipsum"
        dummyItem.desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        dummyItem.due = Date.now

        return DetailView(vm: TaskViewModel(), task: dummyItem)
            .environment(\.managedObjectContext, context)
    }
}
