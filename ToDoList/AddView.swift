//
//  AddView.swift
//  ToDoList
//
//  Created by Jonathan Valentino on 02/08/23.
//

import SwiftUI

struct AddView: View {
    @Binding var showModal: Bool
    
    @State var title: String = ""
    @State var description: String = ""
    @State var due = Date()
    
    @State var showDate = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Title
                    HStack {
                        Spacer()
                            .frame(width: 20)
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15)
                        Spacer()
                            .frame(width: 20)
                        TextField("Title", text: $title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)

                    // Description
                    HStack {
                        Spacer()
                            .frame(width: 20)
                        Image(systemName: "note.text")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15)
                        Spacer()
                            .frame(width: 20)
                        TextField("Description", text: $description)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    
                    // Due Date
                    VStack(spacing: 0){
                        HStack {
                            Spacer()
                                .frame(width: 20)
                            Image(systemName: "calendar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15)
                            Spacer()
                                .frame(width: 20)
                            Text("\(due.formatted(date: .long, time: .omitted))")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                        .frame(height: 50)
                        .background(.white)
                        .onTapGesture {
                            showDate.toggle()
                        }
                        
                        if showDate == true {
                            Divider()
                            DatePicker("", selection: $due)
                                .datePickerStyle(.graphical)
                                .background(.white)
                                .padding()
                        }
                    }
                    .frame(maxHeight: .infinity)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                }
                .padding(20)
                .navigationBarTitle("Add Task", displayMode: .inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button(action: {
                            self.showModal.toggle()
                        }, label: {
                            Text("Cancel")
                        })
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showModal.toggle()
                        }, label: {
                            Text("Save")
                                .fontWeight(.bold)
                        })
                        .disabled(!title.isEmpty && !description.isEmpty ? false : true)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(showModal: .constant(true))
    }
}
