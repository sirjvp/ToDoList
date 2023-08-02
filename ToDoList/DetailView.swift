//
//  DetailView.swift
//  ToDoList
//
//  Created by Jonathan Valentino on 02/08/23.
//

import SwiftUI

struct DetailView: View {
    @State private var showModal = false
    @State var type = "Edit Task"

    @State var title: String
    @State var description: String
    @State var due: String

    var body: some View {
        VStack {
            Form {
                // Title
                Text(title)
                    .font(.headline)

                // Description
                Text(description)
                    .foregroundColor(.gray)

                // Due Date
                HStack {
                    Text("Due Date")
                    Spacer()
                        .frame(maxWidth: .infinity)
                    Text(due)
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
                    SaveView(showModal: $showModal, type: $type, title: title, description: description)
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

// Text(item.timestamp!, formatter: itemFormatter)

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(title: "Lorem ipsum", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", due: "00/00/00")
    }
}
