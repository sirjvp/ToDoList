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
    @State var isFinish = false

    var body: some View {
        VStack(spacing: 0) {
            List {
                Section {
                    Text(task.title ?? "")

                    Text(task.desc ?? "")
                        .foregroundColor(.gray)
                }

                Section {
                    HStack {
                        Text("Due Date")
                        Spacer()
                        Text(task.due ?? Date(), formatter: itemFormatter)
                            .foregroundColor(.gray)
                    }

                    Toggle("Finish", isOn: $isFinish)
                        .onChange(of: isFinish) { _ in
                            vm.editStatus(task: task, status: isFinish ? "complete" : "incomplete")
                        }
                        .onAppear {
                            if task.status == "complete" {
                                isFinish = true
                            }
                        }
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
        dummyItem.status = "complete"

        return DetailView(vm: TaskViewModel(), task: dummyItem)
            .environment(\.managedObjectContext, context)
    }
}
