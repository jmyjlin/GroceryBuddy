//
//  AddView.swift
//  GroceryBuddy
//
//  Created by Jimmy Lin on 5/25/26.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    
    var groceries: GroceryItems
    
    let types = ["Produce", "Dairy", "Meat", "Frozen", "Snacks", "Drinks", "Bakery", "Household", "Personal Care", "Other"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle("Add new grocery item")
            .toolbar {
                Button("Add") {
                    let item = GroceryItem(name: name, type: type)
                    groceries.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview("Add Screen") {
    AddView(groceries: GroceryItems())
}
