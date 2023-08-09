//
//  ContentView.swift
//  ToDoList
//
//  Created by Jonathan Valentino on 02/08/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>

    @StateObject var vm = TaskViewModel()

    @State private var showModal = false
    @State private var type = "Add Task"

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Today")) {
                        ForEach(vm.tasks) { task in
                            NavigationLink {
                                DetailView(vm: vm, task: task)
                            } label: {
                                Text(task.title ?? "No Name")
                            }
                        }
                        .onDelete(perform:
                            withAnimation {
                                vm.deleteItems
                            })
                    }
                }
            }
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        self.showModal.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .sheet(isPresented: $showModal) {
                        SaveView(vm: vm, showModal: $showModal, type: $type)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
